// Basic Imports
import 'package:flutter/material.dart';

// UI Models
import '../../filter_models/market_products_filter.dart';

// Widgets
import '../../widgets/products/product_list_view.dart';
import '../../widgets/products/responsive_product_grid_view.dart';
import '../../widgets/form_widgets/search_bar.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ProductsListScreen extends StatefulWidget {
  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends State<ProductsListScreen> {
  final ProductsFilter productsFilter = ProductsFilter(displayAsBlocks: false);

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 3,
            child: SearchBar(
              controller: productsFilter.searchBarController,
            ),
          ),
          Flexible(
            flex: 1,
            child: FloatingActionButton.extended(
              label: Text("Filtrar"),
              icon: Icon(Icons.filter_alt_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Expanded(
        child: productsFilter.displayAsBlocks
            ? ResponsiveProductGridLayout(
                items: dummyProducts,
              )
            : ProductListView(
                items: dummyProducts,
              ),
      ),
    );
  }
}
