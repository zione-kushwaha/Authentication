//function to show snackbar
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, {Duration duration = const Duration(seconds: 4), Color backgroundColor = Colors.blue}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    duration: duration,
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  ));
}