import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? minLength;
  final int? maxLength;
  final String? helperText;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.keyboardType,
    this.minLength,
    this.maxLength,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              helperText: helperText,
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              labelText: hintText,
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  32,
                ),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            keyboardType: keyboardType,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}
