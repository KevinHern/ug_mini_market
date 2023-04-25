// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/ui/widgets/products/product_block_thumbnail.dart';

// Models
import '../../../domain/models/product.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ResponsiveProductGridLayout extends StatelessWidget {
  final List<Widget> _children;

  ResponsiveProductGridLayout({required List<UGProduct> items})
      : _children = items.map((e) => ProductThumbnail(ugProduct: e)).toList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < ScreenBreakPoints.small.end!) {
          return GridView.count(
            primary: false,
            padding: EdgeInsets.all(padding * gridViewPaddingMultiplier),
            crossAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            mainAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            crossAxisCount: gridViewProductThumbnailSmallCount,
            children: _children,
          );
        } else if (constraints.maxWidth < ScreenBreakPoints.medium.end!) {
          return GridView.count(
            primary: false,
            padding: EdgeInsets.all(padding * gridViewPaddingMultiplier),
            crossAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            mainAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            crossAxisCount: gridViewProductThumbnailMediumCount,
            children: _children,
          );
        } else if (constraints.maxWidth <
            ScreenBreakPoints.largeAlternative.end!) {
          return GridView.count(
            primary: false,
            padding: EdgeInsets.all(padding * gridViewPaddingMultiplier),
            crossAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            mainAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            crossAxisCount: gridViewProductThumbnailLargeAlternativeCount,
            children: _children,
          );
        } else {
          return GridView.count(
            primary: false,
            padding: EdgeInsets.all(padding * gridViewPaddingMultiplier),
            crossAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            mainAxisSpacing:
                padding * gridCrossAxisProductThumbnailSpacingMultiplier,
            crossAxisCount: gridViewProductThumbnailExtraLargeCount,
            children: _children,
          );
        }
      },
    );
  }
}
