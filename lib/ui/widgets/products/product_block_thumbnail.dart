// Basic Imports
import 'package:flutter/material.dart';

// Models
import '../../../domain/models/product.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ProductThumbnail extends StatelessWidget {
  final UGProduct ugProduct;

  const ProductThumbnail({required this.ugProduct});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 180,
      child: Card(
        elevation: 1.0,
        child: InkWell(
          onTap: () => {},
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 3,
                  child: Image.asset('assets/item_box.png'),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    ugProduct.name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
