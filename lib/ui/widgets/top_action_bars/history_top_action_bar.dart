// Basic Imports
import 'package:flutter/material.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class HistoryTopActionBar extends StatelessWidget {
  const HistoryTopActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: topActionBarHeight,
      child: Column(
        children: [
          ListTile(
            leading: FloatingActionButton(
              child: Icon(
                Icons.filter_alt_rounded,
              ),
              onPressed: () => {},
            ),
            title: Text("Total: 1-50 de XXX registros"),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_left_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_right_rounded),
                  ),
                ],
              ),
            ),
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
