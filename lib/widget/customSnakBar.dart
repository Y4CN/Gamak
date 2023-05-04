import 'package:flutter/material.dart';

class CustomSnakBar {
  CustomSnakBar._();
  static getCustomSnakBar(String txt, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        duration: const Duration(
          milliseconds: 1500,
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        content: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              txt,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: 'vazirm',
              ),
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
