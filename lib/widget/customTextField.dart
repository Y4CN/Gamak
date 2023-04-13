
import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  CustomTextFeild({
    super.key,
    required this.controller,
    required this.txt,
  });
  TextEditingController controller;
  String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 14,
        right: 12,
        left: 12,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: txt,
          labelStyle: const TextStyle(fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
