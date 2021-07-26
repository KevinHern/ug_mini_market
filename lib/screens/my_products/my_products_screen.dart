// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';
import 'package:ug_mini_market/models/navigation_model.dart';

// Templates
import 'package:ug_mini_market/templates/dialog_template.dart';
import 'package:ug_mini_market/templates/common_assets_template.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProductsScreen extends StatelessWidget {
  final UGUser user;
  MyProductsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('vendorUid', isEqualTo: this.user.uid)
          .orderBy('productName', descending: false)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshots) {
        if (!snapshots.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        } else {
          if (snapshots.data != null && snapshots.data!.docs.length > 0) {
            return ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FitText(
                          text: 'Mis Productos', fitTextStyle: FitTextStyle.H1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.infinity,
                  child: AccentButton(
                    icon: Icons.add_shopping_cart_outlined,
                    text: 'Añadir Producto',
                    onPressed: () {
                      final navigationModel =
                          Provider.of<NavigationModel>(context, listen: false);
                      navigationModel.pushRoute(
                        route: NavigationModel.screens[5],
                        arguments: [navigationModel.arguments[0], true, null],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Card(
                      child: ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProductCard(
                              user: this.user,
                              productDocument: snapshots.data.docs[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: SingleChildScrollView(
                child: AlertTextTemplate(
                  title: "Aviso",
                  message:
                      "No hay información que cumple con el criterio del filtro.",
                  showAction: false,
                ),
              ),
            );
          }
        }
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final DocumentSnapshot productDocument;
  final UGUser user;
  ProductCard({required this.user, required this.productDocument});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: ListTile(
        title: Text(
          '${productDocument['productName']}',
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          'Precio: Q${(productDocument['price'].toDouble()).toStringAsFixed(2)}\n'
          'Fecha de Creación: ${productDocument['date']}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onTap: () {
          final navigationModel =
              Provider.of<NavigationModel>(context, listen: false);
          navigationModel.pushRoute(
              route: NavigationModel.screens[5],
              arguments: [
                navigationModel.arguments[0],
                false,
                this.productDocument
              ]);
        },
      ),
    );
  }
}
