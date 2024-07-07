import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

mixin Toasts {
  void showSuccessToast(String description) {
    toastification.show(
      dragToClose: true,
      title: const Text('Success'),
      description: Text(description),
      direction: TextDirection.ltr,
      alignment: Alignment.bottomCenter,
      type: ToastificationType.success,
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  void showErrorToast(String description) {
    toastification.show(
      dragToClose: true,
      title: const Text('Error'),
      description: Text(description),
      direction: TextDirection.ltr,
      alignment: Alignment.bottomCenter,
      type: ToastificationType.error,
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}
