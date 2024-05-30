// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
    final TextInputType keyBoardType;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyBoardType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      keyboardType: keyBoardType,
    );
  }
}
