import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:local_auth/local_auth.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.amberAccent,
              onPrimary: Colors.white,
            ),
        useMaterial3: true,
      ),
      home: const LoginScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSaved = false;
  final LocalAuthentication auth = LocalAuthentication();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _passwordCheckKey = GlobalKey<FormState>();

  bool _isPasswordValidLength = false;
  bool _isPasswordContainsNumber = false;
  bool _isPasswordContainsUpper = false;
  bool _isPasswordContainsSpecialCharacter = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordValidation);
    _passwordFocusNode.addListener(() {
      if (_passwordCheckKey.currentContext != null &&
          _passwordFocusNode.hasFocus) {
        Scrollable.ensureVisible(
          _passwordCheckKey.currentContext!,
          duration: const Duration(milliseconds: 1000),
        );
      }
    });
  }

  void _updatePasswordValidation() {
    final password = _passwordController.text;
    bool hasMinLength = password.trim().length >= 6;
    bool hasNumber = password.contains(RegExp(r'\d'));
    bool hasUpper = password.contains(RegExp(r'[A-Z]'));
    bool hasSpecialCharacter =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    setState(() {
      _isPasswordValidLength = hasMinLength;
      _isPasswordContainsNumber = hasNumber;
      _isPasswordContainsUpper = hasUpper;
      _isPasswordContainsSpecialCharacter = hasSpecialCharacter;
    });
  }

  Future<void> checkBiometric() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.strong)) {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
        );
        if (authenticated) {
          toastification.show(
            title: const Text('User authenticated'),
            direction: TextDirection.ltr,
            alignment: Alignment.bottomCenter,
            type: ToastificationType.success,
            showProgressBar: false,
            autoCloseDuration: const Duration(seconds: 2),
          );
        } else {
          toastification.show(
            title: const Text('User not authenticated'),
            direction: TextDirection.ltr,
            alignment: Alignment.bottomCenter,
            showProgressBar: false,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 2),
          );
        }
      } else {
        toastification.show(
          title: const Text('Error'),
          description: const Text('Fingerprint is not enabled in this device'),
          showProgressBar: false,
          direction: TextDirection.ltr,
        );
      }
    } else {
      toastification.show(
        title: const Text('Error'),
        description: const Text('Biometric is not available on this device'),
        showProgressBar: false,
        direction: TextDirection.ltr,
      );
    }
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xff92da44), Color(0xff2fa5b7)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          shadowColor: Colors.grey.withOpacity(0.4),
          title: Text(widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              )),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Container(
              height: 1,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: SingleChildScrollView(
          child: Animate(
        effects: const [
          FadeEffect(),
          ScaleEffect(),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Hello there',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login to application',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Save id',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Checkbox(
                                visualDensity: VisualDensity.compact,
                                value: _isSaved,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isSaved = value!;
                                  });
                                },
                                side: WidgetStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                    color: _isSaved
                                        ? Colors.transparent
                                        : Colors.grey,
                                  ),
                                ),
                                checkColor: Colors.white,
                                fillColor: WidgetStateProperty.all(
                                  _isSaved
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    } else if (!value.contains(RegExp(r'\d'))) {
                      return 'Password must contain at least one number';
                    } else if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    } else if (!value
                        .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'Password must contain at least one special character';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    suffixIcon: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.disabled_visible,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: _passwordFocusNode.hasFocus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isPasswordValidLength
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: _isPasswordValidLength
                                ? Colors.green
                                : Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Password must be at least 6 characters',
                            style: TextStyle(
                              color: _isPasswordValidLength
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            _isPasswordContainsNumber
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: _isPasswordContainsNumber
                                ? Colors.green
                                : Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Password must contain at least one number',
                            style: TextStyle(
                              color: _isPasswordContainsNumber
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            _isPasswordContainsUpper
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: _isPasswordContainsUpper
                                ? Colors.green
                                : Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Password must contain at least one uppercase letter',
                            style: TextStyle(
                              color: _isPasswordContainsUpper
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            _isPasswordContainsSpecialCharacter
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: _isPasswordContainsSpecialCharacter
                                ? Colors.green
                                : Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Password must contain at least one special character',
                            style: TextStyle(
                              color: _isPasswordContainsSpecialCharacter
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Forgot ID or password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        key: _passwordCheckKey,
                        onPressed: () {
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          checkBiometric();
                        },
                        child: Icon(
                          Icons.fingerprint,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New to Application? ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.blue,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
