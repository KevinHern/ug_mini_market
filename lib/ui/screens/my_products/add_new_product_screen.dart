// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/ui/widgets/form_widgets/responsive_choice_chip_selection.dart';

// Widgets
import '../../widgets/form_widgets/form_buttons.dart';
import '../../widgets/form_widgets/responsive_multi_filter_chips_selection.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';
import 'package:ug_mini_market/ui/screens/my_products/screen_widgets/form_input_fields.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class AddNewProductFormScreen extends StatefulWidget {
  @override
  AddNewProductFormState createState() => AddNewProductFormState();
}

class AddNewProductFormState extends State<AddNewProductFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FilterChipModel categoryOptions =
      FilterChipModel(labels: ProductCategories.categories);
  final ChoiceChipModel negotiablePriceOptions = ChoiceChipModel(
    labels: ChoiceChipModel.negotiableLabels,
    selectedLabel: 0,
  );

  // Controllers
  late final TextEditingController nameController,
      descriptionController,
      detailsController,
      quantityController,
      priceController;

  @override
  void initState() {
    super.initState();

    // Initializing controllers
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    detailsController = TextEditingController();
    quantityController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar: const GoBackTopActionBar(message: 'Añadir Nuevo Producto'),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              MyProductsFormFields(
                nameController: nameController,
                descriptionController: descriptionController,
                detailsController: detailsController,
                quantityController: quantityController,
                priceController: priceController,
              ),
            ],
          ),
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        const Text("Precio Negociable"),
        const SizedBox(height: padding * formPaddingMultiplier),
        ResponsiveChoiceChipSelection(
            choiceChipModel: negotiablePriceOptions, mandatoryField: true),
        const SizedBox(height: padding * formPaddingMultiplier),
        const Text("Categorías"),
        const SizedBox(height: padding * formPaddingMultiplier),
        ResponsiveMultiFilterChips(
          filterChip: categoryOptions,
          mandatoryField: true,
        ),
        FormButtons(
          buttons: [
            FilledButton.tonalIcon(
              icon: Icon(Icons.preview_rounded),
              label: Text("Preview"),
              onPressed: () {},
            ),
            FilledButton.tonalIcon(
              icon: Icon(Icons.cancel_rounded),
              label: Text("Reset"),
              onPressed: () {},
            ),
            FilledButton.icon(
              icon: Icon(Icons.save_rounded),
              label: Text("Guardar"),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}
