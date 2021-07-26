// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/models/boolean_wrapper.dart';
import 'package:provider/provider.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';

// Templates
import 'package:ug_mini_market/templates/common_assets_template.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';
import 'package:ug_mini_market/templates/progress_dialog.dart';
import 'package:ug_mini_market/templates/form_template.dart';

// Backend
import 'package:firebase_auth/firebase_auth.dart';

class UserInformationScreen extends StatelessWidget {
  final UGUser user;
  final TextEditingController _password = TextEditingController();
  final BooleanWrapper _hidePassword = BooleanWrapper(value: true);
  UserInformationScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FitText(text: 'Perfil', fitTextStyle: FitTextStyle.H1),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          UserInfoBlock(user: this.user),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              thickness: 2.0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          UserConfigPassword(
              password: this._password, hidePassword: this._hidePassword),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String title, value;
  UserInfoRow({required this.title, required this.value});

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
          child: FitText(
            text: this.value,
            fitTextStyle: FitTextStyle.B1,
            fitAlignment: Alignment.centerRight,
            textAlignment: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class UserRating extends StatelessWidget {
  final double? rating;
  final double starSize;
  UserRating({required this.starSize, @required this.rating});

  @override
  Widget build(BuildContext context) {
    return (this.rating == null)
        ? const SizedBox(
            height: 0.0,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (this.rating! >= 1.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 0.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! >= 2.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 1.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! >= 3.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 2.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! >= 4.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 3.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! == 5)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 4.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
            ],
          );
  }
}

class UserInfoBlock extends StatelessWidget {
  final UGUser user;
  static const double spacing = 12.0;
  UserInfoBlock({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: spacing, horizontal: spacing / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoRow(title: 'Nombre(s)', value: this.user.name),
            const SizedBox(
              height: spacing,
            ),
            UserInfoRow(title: 'Apellido(s)', value: this.user.lastName),
            const SizedBox(
              height: spacing,
            ),
            UserInfoRow(title: 'Correo', value: this.user.email),
            const SizedBox(
              height: spacing,
            ),
            UserInfoRow(title: 'Carnet', value: this.user.id.toString()),
            const SizedBox(
              height: spacing,
            ),
            UserInfoRow(title: 'Facultad', value: this.user.faculty),
            const SizedBox(
              height: spacing,
            ),
            UserInfoRow(
                title: 'Rating',
                value: (this.user.rating == null)
                    ? 'Sin calificación'
                    : '${(this.user.rating! / this.user.noRatings).toStringAsFixed(1)}/5.0'),
            UserRating(
                starSize: 12.0,
                rating: (this.user.rating == null)
                    ? null
                    : (this.user.rating! / this.user.noRatings)),
          ],
        ),
      ),
    );
  }
}

class UserConfigPassword extends StatelessWidget {
  final TextEditingController password;
  final BooleanWrapper hidePassword;
  static const double spacing = 12.0;
  UserConfigPassword({
    required this.password,
    required this.hidePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child:
                  FitText(text: 'Configuración', fitTextStyle: FitTextStyle.H1),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: spacing, vertical: spacing / 2),
            child: ChangeNotifierProvider<BooleanWrapper>(
              create: (context) => this.hidePassword,
              child: Consumer<BooleanWrapper>(
                builder: (_, __, ___) {
                  return InputPassword(
                    controllers: [this.password],
                    booleanWrapper: this.hidePassword,
                    onPressed: () =>
                        this.hidePassword.value = !this.hidePassword.value,
                    lastInput: true,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: AccentButton(
                icon: Icons.refresh,
                text: 'Reset',
                onPressed: () => this.password.text = '',
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: AccentButton(
                    icon: Icons.update,
                    text: 'Actualizar',
                    onPressed: () async {
                      String message = "";

                      if (this.password.text.isNotEmpty) {
                        ProgressDialog pd = ProgressDialog(
                          text: 'Actualizando...',
                          progressDialogIndicator:
                              ProgressDialogIndicator.CIRCULAR,
                        );
                        pd.setProgressIndicatorStyle(width: 6.0);
                        pd.showProgressDialog(context: context);

                        await FirebaseAuth.instance.currentUser!
                            .updatePassword(this.password.text)
                            .then((value) => message =
                                'Su contraseña se actualizó correctamente.')
                            .catchError((error) {
                          message =
                              'Ocurrió un error, por favor intenta de nuevo.';
                          print(
                              'Exception on Password Update: ${error.toString()}');
                        });

                        pd.dismiss(context: context);
                      } else
                        message = 'Por favor, introduce una contraseña.';
                      DialogTemplate.showMessage(
                          context: context, message: message);
                    })),
          ],
        ),
      ],
    );
  }
}
