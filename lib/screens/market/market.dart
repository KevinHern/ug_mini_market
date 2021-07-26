// Basic imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ug_mini_market/templates/common_assets_template.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';
import 'package:ug_mini_market/models/navigation_model.dart';

// Templates
import 'package:ug_mini_market/templates/dialog_template.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';

class UGMarket extends StatelessWidget {
  final String userId = '';
  final UGUser user;
  UGMarket({required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(['Electronica', 'Dibujo Técnico', 'Otros']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data != null) {
            return ChangeNotifierProvider<ValueNotifier<String>>(
              create: (context) => ValueNotifier<String>(snapshot.data[0]),
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                children: [
                  // Filter,
                  Consumer<ValueNotifier<String>>(
                    builder: (_, filter, __) {
                      final List<int> options = [];
                      for (int i = 0; i < snapshot.data!.length; i++)
                        options.add(i);

                      return Card(
                        child: ListTile(
                          title: Text(
                            filter.value,
                            style: Theme.of(context).textTheme.headline2,
                            textAlign: TextAlign.center,
                          ),
                          trailing: AccentButton(
                            icon: Icons.filter_alt,
                            onPressed: () => DialogTemplate.showSelectOptions(
                              context: context,
                              title: 'Opciones',
                              options: options,
                              captions: snapshot.data,
                              aftermath: (index) =>
                                  filter.value = snapshot.data[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: Consumer<ValueNotifier<String>>(
                      builder: (_, filter, __) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('products')
                              .where('category', isEqualTo: filter.value)
                              .where('vendorUid', isNotEqualTo: this.user.uid)
                              .orderBy('vendorUid', descending: false)
                              .orderBy('productName', descending: false)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshots) {
                            if (!snapshots.hasData) {
                              return const Center(
                                child: const CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshots.data != null &&
                                  snapshots.data!.docs.length > 0) {
                                return ListView.builder(
                                  itemCount: snapshots.data!.docs.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: ProductCard(
                                        productDocument:
                                            snapshots.data.docs[index],
                                        user: this.user,
                                      ),
                                    );
                                  },
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
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: SingleChildScrollView(
                child: AlertTextTemplate(
                  title: "Aviso",
                  message:
                      "No es pobile registrar nuevos productos por el momento. Intenta más tarde.",
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

/*
Product Document Model:
{
  Id: <id>
  productName: <String>
  description: <String>
  date: <String>
  details: <String>
  vendorName: <String>
  vendorId: <int>
  price: <uint>
  negotiable: <bool>
  quantity: <uint> or null
  category: <String>
}
 */
class ProductCard extends StatelessWidget {
  final DocumentSnapshot productDocument;
  final UGUser user;
  ProductCard({required this.productDocument, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '${productDocument['productName']}',
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          'Precio: Q${(productDocument['price'].toDouble()).toStringAsFixed(2)}\n'
          'Vendedor: ${productDocument['vendorName']}\n'
          'Carnet del Vendedor: ${productDocument['vendorId']}\n'
          'Cantidad: ${productDocument['quantity']}\n'
          'Ultima Fecha de Modificación:\n${productDocument['date']}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onTap: () {
          final navigationModel =
              Provider.of<NavigationModel>(context, listen: false);
          navigationModel.pushRoute(
              route: NavigationModel.screens[6],
              arguments: [navigationModel.arguments[0], this.productDocument]);
        },
      ),
    );
  }
}
