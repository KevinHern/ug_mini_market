// Basic Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

// Abstract Classes
import 'package:ug_mini_market/abstract_classes/abstract_market_product.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';

// Templates
import 'package:ug_mini_market/templates/common_assets_template.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';
import 'package:ug_mini_market/templates/form_template.dart';
import 'package:ug_mini_market/templates/progress_dialog.dart';

class ProductInformationScreen extends MarketProductWidget {
  ProductInformationScreen({required product, required UGUser user})
      : super(product: product, user: user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FitText(
                  text: 'Información del\nProducto',
                  fitTextStyle: FitTextStyle.H1),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ProductInfoBlock(
            product: super.product,
            user: this.user,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              thickness: 2.0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          ProductDetailsBlock(
            product: super.product,
            user: this.user,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              thickness: 2.0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          // Buttons
          ContactVendor(
            product: this.product!,
            user: this.user,
          ),
        ],
      ),
    );
  }
}

class ProductInfoRow extends StatelessWidget {
  final String title, value;
  ProductInfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: FitText(
            text: this.title,
            fitTextStyle: FitTextStyle.H3,
            fitAlignment: Alignment.centerRight,
            textAlignment: TextAlign.right,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Text(
            this.value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          /*child: FitText(
            text: this.value,
            fitTextStyle: FitTextStyle.B1,
            fitAlignment: Alignment.centerRight,
            textAlignment: TextAlign.right,
          ),*/
        ),
      ],
    );
  }
}

class ProductInfoBlock extends MarketProductWidget {
  // REPLACE THIS with a DocumentSnapshot!
  static const double spacing = 12.0;
  ProductInfoBlock({required product, required UGUser user})
      : super(product: product, user: user);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: spacing, horizontal: spacing / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductInfoRow(
                title: 'Nombre del Producto',
                value: super.product!['productName']),
            const SizedBox(
              height: spacing,
            ),
            ProductInfoRow(
                title: 'Descripción del Producto',
                value: super.product!['description']),
            const SizedBox(
              height: spacing,
            ),
            ProductInfoRow(
                title: 'Vendedor',
                value: '${super.product!['vendorName']}\n'
                    'Carnet: ${super.product!['vendorId']}'),
            const SizedBox(
              height: spacing,
            ),
            ProductInfoRow(
                title:
                    'Precio ${super.product!['negotiable'] ? '(Negociable)' : '(No Negociable)'}',
                value:
                    'Q${super.product!['price'].toDouble().toStringAsFixed(2)}'),
            const SizedBox(
              height: spacing,
            ),
            ProductInfoRow(
                title: 'Disponibilidad',
                value: '${super.product!['quantity']} unidades'),
            const SizedBox(
              height: spacing,
            ),
            ProductInfoRow(
                title: 'Categoría', value: '${super.product!['category']}'),
            const SizedBox(
              height: spacing,
            ),
            ProductInfoRow(
                title: 'Fecha de Última Actualización',
                value: '${super.product!['date']}'),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsBlock extends MarketProductWidget {
  // REPLACE THIS with a DocumentSnapshot!
  ProductDetailsBlock({required product, required UGUser user})
      : super(product: product, user: user);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: FitText(
                  text: 'Detalles\nAdicionales', fitTextStyle: FitTextStyle.H1),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ProductInfoRow(
                title: 'Considerar lo siguiente:',
                value: super.product!['details'],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContactVendor extends StatefulWidget {
  final DocumentSnapshot product;
  final UGUser user;
  ContactVendor({required this.product, required this.user});

  ContactVendorState createState() =>
      ContactVendorState(user: this.user, product: this.product);
}

class ContactVendorState extends State<ContactVendor> {
  final TextEditingController messageController;
  final DocumentSnapshot product;
  final UGUser user;
  ContactVendorState({required this.product, required this.user})
      : this.messageController = TextEditingController(
            text:
                '¡Hola! ¿Podemos ponernos de acuerdo? Estoy interesado en este producto: ${product['productName']}.');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputMultiText(
                caption:
                    'Mensaje (se le enviará un correo al vendedor con tu mensaje)',
                icon: Icons.email,
                controller: messageController),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              child: AccentButton(
                icon: Icons.delete,
                text: 'Borrar',
                onPressed: () => this.messageController.text = '',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: AccentButton(
                icon: Icons.send,
                text: 'Enviar',
                onPressed: () async {
                  print(this.product['vendorEmail']);
                  ProgressDialog pd = ProgressDialog(
                    text: 'Enviando...',
                    progressDialogIndicator: ProgressDialogIndicator.CIRCULAR,
                    isDismissible: true,
                  );
                  pd.setProgressIndicatorStyle(width: 6.0);
                  pd.showProgressDialog(context: context);

                  String message = messageController.text;
                  // Send Email
                  final Email email = Email(
                    body: message,
                    subject: 'UG-Market: ${this.product['productName']}',
                    recipients: [this.product['vendorEmail']],
                    isHTML: false,
                  );

                  try {
                    await FlutterEmailSender.send(email);
                    message = 'Email enviado';
                    // Add this product to pending to both client and vendor
                    // Get a new write batch
                    WriteBatch batch = FirebaseFirestore.instance.batch();

                    /*
                    Status:
                    - 0: Cancelled
                    - 1: Pending
                    - 2: Complete
                  */
                    String timestamp =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    DocumentReference ugClient = FirebaseFirestore.instance
                        .collection("users")
                        .doc(this.user.uid)
                        .collection('transactions')
                        .doc(timestamp);
                    batch.set(ugClient, {
                      'status': 1,
                      'vendorName': this.product['vendorName'],
                      'vendorUid': this.product['vendorUid'],
                      'vendorId': this.product['vendorId'],
                      'email': this.product['vendorEmail'],
                      'productName': this.product['productName'],
                      'isMeVendor': false,
                      'date': null,
                    });

                    DocumentReference ugVendor = FirebaseFirestore.instance
                        .collection("users")
                        .doc(this.product['vendorUid'])
                        .collection('transactions')
                        .doc(timestamp);
                    batch.set(ugVendor, {
                      'status': 1,
                      'clientName': '${this.user.name} ${this.user.lastName}',
                      'clientUid': '${this.user.uid}',
                      'clientId': this.user.id,
                      'email': '${this.user.email}',
                      'productName': this.product['productName'],
                      'isMeVendor': true,
                      'date': null,
                    });

                    await batch
                        .commit()
                        .then((value) => message =
                            'Se ha registrado exitosamente la transacción.')
                        .catchError((error) {
                      message =
                          'Ocurrió un error al registrar la transacción, por favor intenta de nuevo.';
                      print(
                          'Exception on Registering Transaction on both sides: ${error.toString()}');
                    });
                  } catch (error) {
                    print(email.toJson());
                    message =
                        'Ocurrió un error al enviar el Email. Intenta de nuevo';
                    print('Error in sending email: ${error.toString()}');
                  }

                  pd.dismiss(context: context);
                  DialogTemplate.showMessage(
                      context: context, message: message);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}
