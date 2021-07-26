// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Templates
import 'package:ug_mini_market/templates/common_assets_template.dart';

class Grid extends StatelessWidget {
  const Grid(
      {Key? key,
      required this.numColumns,
      required this.children,
      required this.staggeredTiles,
      this.horizontalPadding = 16.0,
      this.verticalPadding = 16.0})
      : super(key: key);

  final int numColumns;
  final List<Widget> children;
  final List<StaggeredTile> staggeredTiles;
  final double horizontalPadding, verticalPadding;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: numColumns,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      padding: EdgeInsets.symmetric(
        horizontal: this.horizontalPadding,
        vertical: this.verticalPadding,
      ),
      children: children,
      staggeredTiles: staggeredTiles,
    );
  }
}

class BoxTile extends StatelessWidget {
  const BoxTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final Color backgroundColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InteractiveTile(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                  color: backgroundColor,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: icon,
                  )),
              const SizedBox(
                height: 16.0,
              ),
              FitText(
                text: title,
                fitTextStyle: FitTextStyle.H2,
              ),
            ],
          ),
        ),
        onTap: () {
          this.onTap();
        });
  }
}

class LargeTile extends StatelessWidget {
  const LargeTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.onTap,
    this.alignLeft = true,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final Color backgroundColor;
  final Function onTap;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    return InteractiveTile(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment:
                (alignLeft) ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (alignLeft)
                  ? Material(
                      color: backgroundColor,
                      shape: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: icon,
                      ))
                  : FitText(
                      text: title,
                      fitTextStyle: FitTextStyle.H1,
                      fitAlignment: Alignment.centerRight,
                      textAlignment: TextAlign.right,
                    ),
              const SizedBox(
                width: 16.0,
              ),
              (alignLeft)
                  ? FitText(
                      text: title,
                      fitTextStyle: FitTextStyle.H1,
                      fitAlignment: Alignment.centerLeft,
                      textAlignment: TextAlign.left,
                    )
                  : Material(
                      color: backgroundColor,
                      shape: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: icon,
                      )),
            ],
          ),
        ),
        onTap: onTap);
  }
}
