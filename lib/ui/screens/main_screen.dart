// Basic Imports
import 'package:flutter/material.dart';

// Widgets
import '../widgets/screen/screen_layout.dart';

// Screens

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < ScreenBreakPoints.small.end!) {
          return ScreenLayout();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("UG Market"),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.account_circle_rounded)),
                ),
              ],
            ),
            body: ScreenLayout(),
          );
        }
      },
    );
  }
}
