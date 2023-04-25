// Basic Imports
import 'package:flutter/material.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class GoBackTopActionBar extends StatelessWidget {
  final String message;

  const GoBackTopActionBar({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: topActionBarHeight,
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
              ),
              onPressed: () => {},
            ),
            title: Text(message),
          ),
          Divider(
            thickness: 3,
            color: Colors.black87,
            indent: dividerIndentPadding,
            endIndent: dividerIndentPadding,
          ),
        ],
      ),
      color: Colors.white,
    );
  }
}
