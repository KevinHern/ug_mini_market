// Basic Imports
import 'package:flutter/material.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class TextLabelEdit extends StatelessWidget {
  final String label, value;
  final Function onPressed;

  const TextLabelEdit({
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            "$label :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Text(value),
        ),
        Flexible(
          flex: 1,
          child: FilledButton.tonal(
            child: Icon(Icons.edit),
            onPressed: () => onPressed(),
          ),
        ),
        const Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: const SizedBox(
            width: padding,
          ),
        ),
      ],
    );
  }
}
