// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldFilled extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final String labelText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final bool readOnly, obscureText;
  final int? maxLines, maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String? value) validator;

  const TextFormFieldFilled({
    required this.controller,
    required this.keyboardType,
    required this.textCapitalization,
    required this.textInputAction,
    required this.validator,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.maxLength,
    this.inputFormatters,
    this.readOnly = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        border: UnderlineInputBorder(),
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      controller: controller,
      validator: (String? value) => validator(value),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
    );
  }
}
