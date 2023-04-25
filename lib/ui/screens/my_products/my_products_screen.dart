// Basic Imports
import 'package:flutter/material.dart';

// Widgets
import '../../widgets/products/responsive_product_grid_view.dart';
import '../../widgets/form_widgets/search_bar.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class MyProductsListScreen extends StatelessWidget {
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 3,
            child: SearchBar(
              controller: searchBarController,
            ),
          ),
          Flexible(
            flex: 1,
            child: FloatingActionButton.extended(
              label: Text("Añadir"),
              icon: Icon(Icons.add_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Expanded(
        child: ResponsiveProductGridLayout(
          items: dummyProducts,
        ),
      ),
    );
  }
}
