// Basic Imports
import 'package:flutter/material.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class NotificationsTopActionBar extends StatelessWidget {
  const NotificationsTopActionBar();

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
            title: Text("Total: XX notifications"),
            trailing: FilledButton.icon(
              icon: Icon(Icons.check_circle_rounded),
              label: Text("Confirmar Todos"),
              onPressed: () {},
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
