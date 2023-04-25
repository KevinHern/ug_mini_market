// Basic Imports
import 'package:flutter/material.dart';

// Widgets
import 'package:ug_mini_market/ui/widgets/products/product_tile_view.dart';

// Models
import '../../../domain/models/product.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ProductListView extends StatelessWidget {
  final List<UGProduct> items;

  const ProductListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        indent: dividerIndentPadding * dividerIndentListViewPaddingMultiplier,
        endIndent:
            dividerIndentPadding * dividerIndentListViewPaddingMultiplier,
      ),
      itemBuilder: (context, index) {
        return ProductTileView(item: items[index]);
      },
    );
  }
}
