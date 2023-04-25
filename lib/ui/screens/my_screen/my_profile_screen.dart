// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/domain/models/ug_user.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

// Widgets
import '../../widgets/star_rating_visualizer.dart';

class MyProfileScreen extends StatelessWidget {
  final UGUser ugUser;
  const MyProfileScreen({required this.ugUser});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/u_galileo.jpg'),
              radius: 100,
            ),
            const SizedBox(
              height: padding * 3,
            ),
            Text(
              "${ugUser.names}\n${ugUser.lastNames}",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: padding * 8),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Carnet: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ugUser.id.toString()),
                    ]),
                  ),
                  const SizedBox(height: padding * listTextPaddingMultiplier),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Faculty: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ugUser.faculty),
                    ]),
                  ),
                  const SizedBox(height: padding * listTextPaddingMultiplier),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Email: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ugUser.email),
                    ]),
                  ),
                  const SizedBox(height: padding * listTextPaddingMultiplier),
                  Text(
                    "Rating:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: padding * listTextPaddingMultiplier),
                ],
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth < ScreenBreakPoints.small.end!) {
                  return Column(
                    children: [
                      StarRatingVisualizer(
                        starSize: 44,
                        rating: ugUser.rating,
                      ),
                      const SizedBox(
                          height: padding * listTextPaddingMultiplier * 0.5),
                      Text("ABC Ratings"),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 3,
                        child: StarRatingVisualizer(
                          starSize: 44,
                          rating: ugUser.rating,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text("ABC Ratings"),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: padding * formButtonsPaddingMultiplier),
            FloatingActionButton.extended(
              onPressed: () => {},
              icon: Icon(Icons.edit),
              label: Text("Editar Información"),
            ),
          ],
        ),
      ),
    );
  }
}
