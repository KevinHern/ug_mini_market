// Basic Imports
import 'package:flutter/material.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class FormButtons extends StatelessWidget {
  final List<Widget> buttons;

  const FormButtons({required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: padding * formPaddingMultiplier),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          ),
        ),
      ],
    );
  }
}
