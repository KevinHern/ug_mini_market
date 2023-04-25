// Basic Imports
import 'package:flutter/material.dart';

class DropdownInputField<T> extends StatelessWidget {
  final TextEditingController controller;
  final List<T> items;
  final String labelText;
  final Icon prefixIcon;
  final Icon? suffixIcon;

  const DropdownInputField(
      {required this.controller,
      required this.items,
      required this.labelText,
      required this.prefixIcon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        filled: true,
        border: UnderlineInputBorder(),
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      items: items
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: Text(e.toString()),
              ))
          .toList(),
      onChanged: (T? value) => {},
      isExpanded: true,
    );
  }
}
