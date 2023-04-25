// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/domain/models/product.dart';

// Utils
import '../../../utils/constants.dart';

class ProductTileView extends StatelessWidget {
  final UGProduct item;

  const ProductTileView({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/item_box_40p.png'),
      title: Text(
          "${item.name}: Q${item.price.toStringAsFixed(acceptedNumberDecimals)}"),
      subtitle: Text(
          "Vendedor: <Placeholder Name>\nDisponibilidad: ${item.quantity} unidades"),
      onTap: () {},
    );
  }
}
