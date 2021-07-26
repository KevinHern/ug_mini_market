// Basic imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';
import 'package:ug_mini_market/models/filter_model.dart';

// Templates
import 'package:ug_mini_market/templates/common_assets_template.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';

// Filter between COMPLETED, PENDING, CANCELLED

class TransactionsScreen extends StatelessWidget {
  final UGUser user;
  TransactionsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ChangeNotifierProvider<FilterModel>(
        create: (context) => FilterModel(caption: 'Pendiente', option: 1),
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: FitText(
                    text: 'Transacciones', fitTextStyle: FitTextStyle.H1),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Consumer<FilterModel>(
              builder: (_, filter, __) {
                final captions = ['Cancelados', 'Pendiente', 'Completados'];
                return Card(
                  child: ListTile(
                    title: Text(
                      filter.caption,
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    trailing: AccentButton(
                      icon: Icons.filter_alt,
                      onPressed: () {
                        DialogTemplate.showSelectOptions(
                          context: context,
                          title: 'Filtrar por',
                          options: const [0, 1, 2],
                          captions: captions,
                          aftermath: (int option) {
                            switch (option) {
                              case 0:
                              case 1:
                              case 2:
                                filter.setFilter(
                                    caption: captions[option], option: option);
                                break;
                              default:
                                break;
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Consumer<FilterModel>(
              builder: (_, filter, __) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: Card(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(this.user.uid)
                          .collection('transactions')
                          .where('status', isEqualTo: filter.option)
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: TransactionInfoCard(
                                    transactionDocument:
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
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
Transaction Model {
  'status': COMPLETED/ONGOING/CANCELLED (2, 1, 0 respectively)
  'isMeVendor: <bool>
  'interested': <Other person's name + lastname>
  'object': <String>
  'price': <double>
  'quantity': <double?>
  'date': <String>
}

*/
class TransactionInfoCard extends StatelessWidget {
  final DocumentSnapshot transactionDocument;
  final UGUser user;
  TransactionInfoCard({required this.transactionDocument, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          ((transactionDocument['isMeVendor']) ? 'Venta de ' : 'Compra de ') +
              '${transactionDocument['productName']}',
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          ((transactionDocument['isMeVendor'])
                  ? 'Cliente: ${transactionDocument['clientName']} ${transactionDocument['clientId']}'
                  : 'Vendedor: ${transactionDocument['vendorName']} ${transactionDocument['vendorId']}') +
              '\nEmail: ${transactionDocument['email']}\n'
                  'Fecha Inicio: ${DateTime.fromMillisecondsSinceEpoch(int.parse(transactionDocument.id)).day}/${DateTime.fromMillisecondsSinceEpoch(int.parse(transactionDocument.id)).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(transactionDocument.id)).year}\n\n'
                  'Status: ${(transactionDocument['status'] == 0) ? 'Cancelado' : (transactionDocument['status'] == 1) ? 'Pendiente' : 'Completado'}\n'
                  'Fecha Fin: ${(transactionDocument['date'] == null) ? '---' : '${DateTime.fromMillisecondsSinceEpoch(transactionDocument['date']).day}/${DateTime.fromMillisecondsSinceEpoch(transactionDocument['date']).month}/${DateTime.fromMillisecondsSinceEpoch(transactionDocument['date']).year}'}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: (transactionDocument['status'] != 1)
            ? null
            : AccentButton(
                icon: Icons.edit,
                onPressed: () async {
                  int date = DateTime.now().millisecondsSinceEpoch;
                  if (this.transactionDocument['isMeVendor']) {
                    String message = "Operación cancelada.";
                    await DialogTemplate.showSelectOptions(
                      context: context,
                      title: 'Editar Status',
                      options: const [0, 1],
                      captions: const ['Cancelar', 'Completar'],
                      aftermath: (value) async {
                        WriteBatch batch = FirebaseFirestore.instance.batch();
                        batch.update(this.transactionDocument.reference,
                            {'status': (value == 0) ? 0 : 2, 'date': date});
                        batch.update(
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(this.transactionDocument['clientUid'])
                                .collection('transactions')
                                .doc(this.transactionDocument.id),
                            {'status': (value == 0) ? 0 : 2, 'date': date});
                        print(value);
                        if (value == 1) {
                          batch.set(
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(this.user.uid)
                                  .collection('ratings')
                                  .doc(date.toString()),
                              {
                                'name': transactionDocument['clientName'],
                                'uid': transactionDocument['clientUid'],
                                'status': false,
                              });
                          batch.set(
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(transactionDocument['clientUid'])
                                  .collection('ratings')
                                  .doc(date.toString()),
                              {
                                'name':
                                    '${this.user.name} ${this.user.lastName}',
                                'uid': this.user.uid,
                                'status': false,
                              });
                        }

                        await batch
                            .commit()
                            .then((value) => message =
                                'Se actualizó correctamente el estado de la transacción.')
                            .catchError((error) {
                          message =
                              'Ocurrió un error, por favor inténtalo de nuevo.';
                          print(
                              'Error in Updating Order Status: ${error.toString()}');
                        });
                      },
                    ).catchError((error) => {}).then((value) =>
                        DialogTemplate.showMessage(
                            context: context, message: message));
                  } else {
                    String message = '';
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return BinaryAlert(
                              message: '¿Quieres cancelar la orden?',
                              title: 'Aviso');
                        }).then((value) async {
                      if (value) {
                        WriteBatch batch = FirebaseFirestore.instance.batch();
                        batch.update(this.transactionDocument.reference,
                            {'status': 0, 'date': date});
                        batch.update(
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(this.transactionDocument['vendorUid'])
                                .collection('transactions')
                                .doc(this.transactionDocument.id),
                            {'status': 0, 'date': date});

                        await batch
                            .commit()
                            .then((value) =>
                                message = 'Orden cancelada exitosamente.')
                            .catchError((error) {
                          message = 'Ocurrió un error al cancelar la orden.';
                          print(
                              'Error on Canceling Order: ${error.toString()}');
                        });
                        DialogTemplate.showMessage(
                            context: context, message: message);
                      }
                    });
                  }
                },
              ),
      ),
    );
  }
}
