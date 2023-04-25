// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/domain/models/product.dart';

// Widgets
import '../../widgets/products/product_block_thumbnail.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import 'package:ug_mini_market/ui/widgets/form_widgets/form_buttons.dart';
import '../../widgets/text/text_field_description.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final UGProduct ugProduct;
  final bool isPreview;

  const ProductDetailsScreen(
      {required this.ugProduct, required this.isPreview});

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar: const GoBackTopActionBar(message: "Detalles del Producto"),
      children: [
        Stack(
          children: [
            Center(
              child: Column(
                children: [
                  ProductThumbnail(ugProduct: ugProduct),
                  const SizedBox(height: padding * avatarIconPaddingMultiplier),
                  Text(
                    "${ugProduct.quantity} Disponibles",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !isPreview,
              child: Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border_rounded,
                    size: 48,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: padding * avatarPaddingMultiplier),
        Row(
          children: [
            TextDescription(
              title: 'Vendedor',
              description: '<Placeholder Name>',
            ),
            const SizedBox(
              width: padding,
            ),
            Visibility(
              visible: !isPreview,
              child: FilledButton.tonal(
                child: Icon(Icons.info_rounded),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        TextDescription(
          title: 'Precio',
          description: "Q${ugProduct.price.toStringAsFixed(2)}",
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        TextDescription(
          title: 'Descripción',
          description: "${ugProduct.description}",
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        TextDescription(
          title: 'Detalles',
          description: "${ugProduct.details}",
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        Visibility(
          visible: !isPreview,
          child: FormButtons(
            buttons: [
              FilledButton.icon(
                icon: Icon(Icons.description),
                label: Text("Mandar Solicitud"),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
