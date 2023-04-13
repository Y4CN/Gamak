import 'package:flutter/material.dart';

class CustomSnakBar {
  static getCustomSnakBar(String txt, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1500,
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        content: Center(
          child: Text(
            txt,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'vazirm',
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
