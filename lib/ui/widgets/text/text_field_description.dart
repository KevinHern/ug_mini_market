// Basic Imports
import 'package:flutter/material.dart';

class TextDescription extends StatelessWidget {
  final String title, description;

  const TextDescription({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(children: [
        TextSpan(
          text: "$title: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: description),
      ]),
    );
  }
}
