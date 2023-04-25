// Basic Imports
import 'package:flutter/material.dart';

// Utils
import '../../../utils/constants.dart';

class ScrollableScreenWithTopActionBar extends StatelessWidget {
  final Widget topActionBar;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget>? children;
  final Widget? body;

  const ScrollableScreenWithTopActionBar({
    required this.topActionBar,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.body,
    this.children,
  }) : assert(!(body == null && children == null));

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          topActionBar,
          const SizedBox(height: padding * topActionBarPaddingMultiplier),
          body ??
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding * scrollHorizontalPaddingMultiplier,
                  ),
                  children: children ?? [],
                ),
              ),
        ],
      ),
    );
  }
}
