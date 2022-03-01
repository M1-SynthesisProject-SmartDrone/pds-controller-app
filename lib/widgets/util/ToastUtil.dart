import 'package:flutter/material.dart';

/// Util functions used to display toasts (little notification messages at the bottom of the screen)

class ToastUtil {
  static void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
