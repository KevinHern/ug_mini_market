// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/domain/models/product.dart';

// Widgets
import '../../widgets/form_widgets/input_fields.dart';
import '../../widgets/text/text_label_edit.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import 'package:ug_mini_market/ui/widgets/form_widgets/form_buttons.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ProductRequestCreationScreen extends StatefulWidget {
  final UGProduct ugProduct;

  const ProductRequestCreationScreen({required this.ugProduct});

  @override
  ProductRequestCreationScreenState createState() =>
      ProductRequestCreationScreenState();
}

class ProductRequestCreationScreenState
    extends State<ProductRequestCreationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController placeController;

  @override
  void initState() {
    super.initState();

    // Initializing controllers
    placeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar:
          const GoBackTopActionBar(message: "Filtrar productos por..."),
      children: [
        Form(
          key: _formKey,
          child: MultiLineInputField(
            controller: placeController,
            labelText: "Detalles del Producto",
            prefixIcon: Icon(Icons.place),
            optionalField: true,
          ),
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        TextLabelEdit(
          label: "Hora",
          value: "XX:YY AM/PM",
          onPressed: () {},
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        TextLabelEdit(
          label: "Fecha",
          value: "dd/mm/yyyy",
          onPressed: () {},
        ),
        FormButtons(
          buttons: [
            FilledButton.icon(
              icon: Icon(Icons.send),
              label: Text("Mandar Solicitud"),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
