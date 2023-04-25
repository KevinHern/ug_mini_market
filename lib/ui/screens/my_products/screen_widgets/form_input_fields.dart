// Basic Imports
import 'package:flutter/material.dart';

// Widgets
import '../../../widgets/form_widgets/input_fields.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class MyProductsFormFields extends StatelessWidget {
  final TextEditingController nameController,
      descriptionController,
      detailsController,
      quantityController,
      priceController;

  const MyProductsFormFields(
      {required this.nameController,
      required this.descriptionController,
      required this.detailsController,
      required this.quantityController,
      required this.priceController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleLineInputField(
          controller: nameController,
          textInputAction: TextInputAction.next,
          labelText: "Nombre Producto",
          prefixIcon: Icon(Icons.price_change_rounded),
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        MultiLineInputField(
          controller: descriptionController,
          labelText: "Descripción del Producto",
          prefixIcon: Icon(Icons.description_rounded),
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        MultiLineInputField(
          controller: detailsController,
          labelText: "Detalles del Producto",
          prefixIcon: Icon(Icons.details_rounded),
          optionalField: true,
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        IntegerInputField(
          controller: quantityController,
          textInputAction: TextInputAction.next,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Complete el campo';
            }
            return null;
          },
          labelText: "Cantidad",
          prefixIcon: Icon(Icons.production_quantity_limits_rounded),
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        DecimalInputField(
          controller: priceController,
          textInputAction: TextInputAction.done,
          labelText: "Precio",
          prefixIcon: Icon(Icons.attach_money_rounded),
        ),
      ],
    );
  }
}
