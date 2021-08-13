// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// Abstract Classes
import 'package:ug_mini_market/abstract_classes/abstract_my_products.dart';
import 'package:ug_mini_market/models/ug_user.dart';

// Models
import 'package:ug_mini_market/models/boolean_wrapper.dart';
import 'package:ug_mini_market/models/navigation_model.dart';

// Templates
import 'package:ug_mini_market/templates/common_assets_template.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';
import 'package:ug_mini_market/templates/progress_dialog.dart';
import 'package:ug_mini_market/templates/form_template.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductScreen extends StatefulWidget {
  final bool isCreating;
  final UGUser user;
  final DocumentSnapshot? myProduct;
  ProductScreen(
      {required this.isCreating, @required this.myProduct, required this.user});

  ProductScreenState createState() => ProductScreenState(
      isCreating: this.isCreating, user: this.user, myProduct: this.myProduct);
}

class ProductScreenState extends State<ProductScreen> {
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
  final bool isCreating;
  final BooleanWrapper _negotiable;
  final TextEditingController _productName,
      _description,
      _details,
      _price,
      _quantity;
  final UGUser user;
  final DocumentSnapshot? myProduct;
  static final GlobalKey<FormState> formKey = GlobalKey();
  ProductScreenState(
      {required this.isCreating, @required this.myProduct, required this.user})
      : this._productName = (isCreating)
            ? TextEditingController()
            : TextEditingController(text: myProduct!['productName']),
        this._description = (isCreating)
            ? TextEditingController()
            : TextEditingController(text: myProduct!['description']),
        this._details = (isCreating)
            ? TextEditingController()
            : TextEditingController(text: myProduct!['details']),
        this._price = (isCreating)
            ? TextEditingController()
            : TextEditingController(text: myProduct!['price'].toString()),
        this._negotiable = (isCreating)
            ? BooleanWrapper(value: false)
            : BooleanWrapper(value: myProduct!['negotiable']),
        this._quantity = (isCreating)
            ? TextEditingController()
            : TextEditingController(text: myProduct!['quantity'].toString());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('miscellaneous')
          .doc('products')
          .get(),
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data != null) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<BooleanWrapper>(
                    create: (context) => this._negotiable),
                ChangeNotifierProvider<ValueNotifier<String>>(
                    create: (context) => ValueNotifier((this.isCreating)
                        ? "Sin Seleccionar"
                        : this.myProduct!['category']))
              ],
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FitText(
                        text: (isCreating)
                            ? 'Nuevo Producto'
                            : 'Actualizar\nProducto',
                        fitTextStyle: FitTextStyle.H1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  (this.isCreating)
                      ? MPHelpButton(
                          myProduct: this.myProduct,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: MPDeleteButton(
                                myProduct: this.myProduct,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: MPHelpButton(
                                myProduct: this.myProduct,
                              ),
                            ),
                          ],
                        ),
                  Form(
                    key: formKey,
                    child: MPForm(
                      isCreating: this.isCreating,
                      controllers: [
                        this._productName,
                        this._description,
                        this._details,
                        this._price,
                        this._quantity,
                      ],
                      categories: snapshot.data as DocumentSnapshot,
                      myProduct: this.myProduct,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: MPResetButton(
                          isCreating: isCreating,
                          controllers: [
                            this._productName,
                            this._description,
                            this._details,
                            this._price,
                            this._quantity,
                          ],
                          myProduct: this.myProduct,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: MPSendButton(
                          isCreating: isCreating,
                          controllers: [
                            this._productName,
                            this._description,
                            this._details,
                            this._price,
                            this._quantity,
                          ],
                          //formKey: formKey,
                          myProduct: this.myProduct,
                          user: this.user,
                          formKey: formKey,
                        ),
                      ),
                    ],
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

class MPForm extends MyProductWidget {
  final bool isCreating;
  final List<TextEditingController> controllers;
  final DocumentSnapshot categories;
  static const double spacing = 12.0;
  MPForm(
      {required this.isCreating,
      required this.controllers,
      required this.categories,
      @required DocumentSnapshot? myProduct})
      : super(myProduct: myProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: spacing, horizontal: spacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ValueNotifier<String>>(
              builder: (_, categoryOption, __) {
                final List<int> options = [];
                for (int i = 0; i < this.categories['categories'].length; i++)
                  options.add(i);

                return Card(
                  child: ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text(
                      'Categoría',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle: Text(
                      categoryOption.value,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: AccentButton(
                        icon: Icons.filter_alt,
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          DialogTemplate.showSelectOptions(
                            context: context,
                            title: 'Opciones',
                            options: options,
                            captions: this.categories['categories'],
                            aftermath: (index) => categoryOption.value =
                                this.categories['categories'][index],
                            areRoutingOptions: false,
                          );
                        }),
                  ),
                );
              },
            ),
            const SizedBox(
              height: spacing,
            ),
            InputSingleText(
                caption: '* Nombre Producto',
                icon: Icons.shopping_bag,
                controller: this.controllers[0]),
            const SizedBox(
              height: spacing,
            ),
            InputNumber(
                caption: '* Cantidad',
                icon: Icons.add_shopping_cart,
                controller: this.controllers[4],
                inputFormatter: InputNumberType.INT_POSITIVE),
            const SizedBox(
              height: spacing,
            ),
            InputNumber(
                caption: '* Precio',
                icon: Icons.money,
                controller: this.controllers[3],
                inputFormatter: InputNumberType.PRICE),
            const SizedBox(
              height: spacing,
            ),
            InputMultiText(
                caption: '* Descripción',
                icon: Icons.text_snippet,
                controller: this.controllers[1]),
            const SizedBox(
              height: spacing,
            ),
            InputMultiText(
                caption: '* Detalles',
                icon: Icons.add,
                controller: this.controllers[2]),
            const SizedBox(
              height: spacing,
            ),
            Card(
              child: Consumer<BooleanWrapper>(
                builder: (_, negotiable, __) => InputSwitch(
                    caption: '* Precio Negociable',
                    icon: Icons.wifi_protected_setup_outlined,
                    booleanWrapper: negotiable),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MPHelpButton extends MyProductWidget {
  MPHelpButton({required DocumentSnapshot? myProduct})
      : super(myProduct: myProduct);

  @override
  Widget build(BuildContext context) {
    return AccentButton(icon: Icons.info, text: 'Ayuda', onPressed: () {});
  }
}

class MPDeleteButton extends MyProductWidget {
  MPDeleteButton({required DocumentSnapshot? myProduct})
      : super(myProduct: myProduct);

  @override
  Widget build(BuildContext context) {
    return AccentButton(
      icon: Icons.highlight_remove,
      text: 'Borrar',
      onPressed: () async {
        // Complete this
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return BinaryAlert(
                message: '¿Seguro que quieres borrar ', title: 'Aviso');
          },
        )
            .catchError(
          (onError) =>
              print('Exception ocurred on Binary Alert: tapped somewhere else'),
        )
            .then(
          (value) async {
            if (value) {
              ProgressDialog pd = ProgressDialog(
                text: 'Borrando...',
                progressDialogIndicator: ProgressDialogIndicator.CIRCULAR,
                showPercentage: false,
              );

              pd.setProgressIndicatorStyle(width: 6.0);
              pd.showProgressDialog(context: context);

              String message = "";
              await super
                  .myProduct!
                  .reference
                  .delete()
                  .then((value) =>
                      message = 'El producto se ha borrado exitosamente.')
                  .catchError((error) {
                message = 'Ocurrió un error. Inténtalo de nuevo.';
                print('Error on Delete Product Document: ${error.toString()}');
              });

              pd.dismiss(context: context);

              DialogTemplate.showMessage(context: context, message: message);
              Provider.of<NavigationModel>(context, listen: false).popRoute();
            }
          },
        );
      },
    );
  }
}

class MPResetButton extends MyProductWidget {
  final List<TextEditingController> controllers;
  final bool isCreating;
  // REPLACE THIS with a DocumentSnapshot!
  MPResetButton(
      {required this.isCreating,
      required this.controllers,
      @required myProduct})
      : super(myProduct: myProduct);

  @override
  Widget build(BuildContext context) {
    return AccentButton(
      icon: Icons.highlight_remove,
      text: 'Reset',
      onPressed: () {
        if (this.isCreating) {
          for (TextEditingController controller in controllers)
            controller.text = '';
          Provider.of<BooleanWrapper>(context, listen: false).value = false;
          Provider.of<ValueNotifier<String>>(context, listen: false).value =
              'Sin Seleccionar';
        } else {
          print('hola');
          this.controllers[0].text = this.myProduct!['productName'];
          this.controllers[1].text = this.myProduct!['description'];
          this.controllers[2].text = this.myProduct!['details'];
          this.controllers[3].text = this.myProduct!['price'].toString();
          this.controllers[4].text = this.myProduct!['quantity'].toString();
          Provider.of<BooleanWrapper>(context, listen: false).value =
              this.myProduct!['negotiable'];
          Provider.of<ValueNotifier<String>>(context, listen: false).value =
              this.myProduct!['category'];
        }
      },
    );
  }
}

class MPSendButton extends MyProductWidget {
  final bool isCreating;
  final List<TextEditingController> controllers;
  final UGUser user;
  final GlobalKey<FormState> formKey;

  MPSendButton(
      {required this.isCreating,
      required this.controllers,
      required this.user,
      required this.formKey,
      @required DocumentSnapshot? myProduct})
      : super(myProduct: myProduct);

  @override
  Widget build(BuildContext context) {
    return AccentButton(
      icon: Icons.send,
      text: (this.isCreating) ? 'Registrar' : 'Actualizar',
      onPressed: () async {
        String message = "";

        if (this.formKey.currentState!.validate()) {
          ProgressDialog pd = ProgressDialog(
            text: 'Espere un momento...',
            progressDialogIndicator: ProgressDialogIndicator.CIRCULAR,
            showPercentage: false,
          );

          pd.setProgressIndicatorStyle(width: 6.0);
          pd.showProgressDialog(context: context);

          final todayDate =
              DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();

          if (this.isCreating) {
            await FirebaseFirestore.instance
                .collection('products')
                .add({
                  'productName': this.controllers[0].text,
                  'description': this.controllers[1].text,
                  'details': this.controllers[2].text,
                  'date': todayDate,
                  'vendorName': '${this.user.name} ${this.user.lastName}',
                  'vendorEmail': this.user.email,
                  'vendorId': this.user.id,
                  'vendorUid': this.user.uid,
                  'price': int.parse(this.controllers[3].text),
                  'negotiable':
                      Provider.of<BooleanWrapper>(context, listen: false).value,
                  'quantity': int.parse(this.controllers[4].text),
                  'category':
                      Provider.of<ValueNotifier<String>>(context, listen: false)
                          .value,
                })
                .then((value) =>
                    message = 'Su producto ha sido ingresado exitosamente.')
                .catchError((error) {
                  print('Error in Send Product Document: ${error.toString()}');
                  message =
                      'Ocurrió un error durante el ingreso. Intente de nuevo.';
                });
          } else {
            final Map<String, Object?> toUpdate = {};
            final values = [
              'productName',
              'description',
              'details',
              'price',
              'quantity',
            ];

            for (int i = 0; i < values.length; i++) {
              if (this.myProduct![values[i]] != this.controllers[i].text) {
                if (i == 3)
                  toUpdate[values[i]] = double.parse(this.controllers[i].text);
                else if (i == 4)
                  toUpdate[values[i]] = int.parse(this.controllers[i].text);
                else
                  toUpdate[values[i]] = this.controllers[i].text;
              }
            }

            if (Provider.of<BooleanWrapper>(context, listen: false).value !=
                this.myProduct!['negotiable'])
              toUpdate['negotiable'] =
                  Provider.of<BooleanWrapper>(context, listen: false).value;

            if (Provider.of<ValueNotifier<String>>(context, listen: false)
                    .value !=
                this.myProduct!['category'])
              toUpdate['category'] =
                  Provider.of<ValueNotifier<String>>(context, listen: false)
                      .value;

            if (toUpdate.isEmpty) {
              message = 'No hay campos que actualizar.';
            } else {
              await this
                  .myProduct!
                  .reference
                  .update(toUpdate)
                  .then((value) =>
                      message = 'La actualización se realizó correctamente')
                  .catchError(
                (error) {
                  print('Error on Update Product: ${error.toString()}');
                },
              );
            }
          }

          pd.dismiss(context: context);
        } else
          message = 'Por favor, completa los campos.';

        DialogTemplate.showMessage(context: context, message: message);
      },
    );
  }
}
