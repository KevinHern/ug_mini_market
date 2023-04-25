// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/ui/filter_models/market_products_filter.dart';

// Widgets
import '../../widgets/form_widgets/responsive_choice_chip_selection.dart';
import '../../widgets/form_widgets/responsive_multi_filter_chips_selection.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import 'package:ug_mini_market/ui/widgets/form_widgets/form_buttons.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ProductFilteringScreen extends StatelessWidget {
  final ProductsFilter productsFilter;
  final FilterChipModel categories, faculties;
  final ChoiceChipModel displayFilter;

  ProductFilteringScreen({
    required this.productsFilter,
  })  : categories = FilterChipModel(
            labels: ProductCategories.categories,
            selectedLabels: productsFilter.categories),
        faculties = FilterChipModel(
            labels: UGFaculties.faculties,
            selectedLabels: productsFilter.faculties),
        displayFilter = ChoiceChipModel(
            labels: ChoiceChipModel.displayListBlockLabels,
            selectedLabel: productsFilter.displayAsBlocksInt);

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar:
          const GoBackTopActionBar(message: "Filtrar productos por..."),
      children: [
        const Text("Forma de Desplegar"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveChoiceChipSelection(
          choiceChipModel: displayFilter,
          mandatoryField: true,
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        const Text("Categorías"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveMultiFilterChips(
          filterChip: categories,
          mandatoryField: true,
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        const Text("Facultades"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveMultiFilterChips(
          filterChip: faculties,
          mandatoryField: true,
        ),
        FormButtons(
          buttons: [
            FilledButton.icon(
              icon: Icon(Icons.check_circle_rounded),
              label: Text("Aplicar"),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
