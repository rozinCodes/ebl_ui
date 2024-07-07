import 'package:flutter/material.dart';

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
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
            ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
          // foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Hi',
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
              TextField(
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
                              value: true,
                              onChanged: (bool? value) {
                                print(value);
                              },
                              checkColor: Colors.white,
                              fillColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
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
              //underlined text forgot id or password
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forgot id or password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )

                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.fingerprint,
                      color: Theme.of(context).colorScheme.primary,
                      size: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
              // RichText(
              //   text: TextSpan(
              //     text: 'Don\'t have an account? ',
              //     style: const TextStyle(
              //       color: Colors.black,
              //     ),
              //     children: <TextSpan>[
              //       TextSpan(
              //         text: ' Sign up',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: Theme.of(context).colorScheme.primary,
              //           decoration: TextDecoration.underline,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
