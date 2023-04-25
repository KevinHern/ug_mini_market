// Basic Imports
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const SearchBar({required this.controller});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 720,
          minWidth: 360,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(Icons.search_rounded),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: IconButton(
                icon: Icon(Icons.cancel_rounded),
                onPressed: () => controller.text = "",
              ),
            ),
          ),
          maxLines: 1,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.send,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
