// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/domain/models/ug_user.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

// Widgets
import '../../widgets/star_rating_visualizer.dart';
import '../../widgets/text/text_field_description.dart';

class UGUserProfile extends StatelessWidget {
  final UGUser ugUser;
  const UGUserProfile({required this.ugUser});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/u_galileo.jpg'),
                  radius: 100,
                ),
                const SizedBox(
                  height: padding * avatarIconPaddingMultiplier,
                ),
                Text(
                  "${ugUser.names}\n${ugUser.lastNames}",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: padding * avatarPaddingMultiplier),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextDescription(
                        title: "Carnet",
                        description: ugUser.id.toString(),
                      ),
                      const SizedBox(
                          height: padding * listTextPaddingMultiplier),
                      TextDescription(
                        title: "Faculty",
                        description: ugUser.faculty,
                      ),
                      const SizedBox(
                          height: padding * listTextPaddingMultiplier),
                      TextDescription(
                        title: "Email",
                        description: ugUser.email,
                      ),
                      const SizedBox(
                          height: padding * listTextPaddingMultiplier),
                      Text(
                        "Rating:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          height: padding * listTextPaddingMultiplier),
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
                              height:
                                  padding * listTextPaddingMultiplier * 0.5),
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
              ],
            ),
          ),
          Align(
            alignment: Alignment(-1.0, 0.0),
            child: FloatingActionButton(
              child: Image.asset('assets/report_flag.png'),
              tooltip: "Reportar a usuario",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
