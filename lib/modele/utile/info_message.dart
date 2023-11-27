import 'package:flutter/material.dart';

class InfoMessage {
  String message = "";
  Color messageColor = Colors.transparent;
  bool isVisible = false;

  void displayMessage(String message, bool isError) {
    this.message = message;
    isVisible = true;
    if (isError) {
      messageColor = Colors.red;
    } else {
      messageColor = Colors.green;
    }
  }
}
