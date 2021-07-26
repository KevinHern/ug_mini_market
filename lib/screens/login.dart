// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';
import 'package:ug_mini_market/models/boolean_wrapper.dart';

// Templates
import 'package:ug_mini_market/templates/progress_dialog.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';
import 'package:ug_mini_market/templates/common_assets_template.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum ScreenType { LOGIN, SIGN_UP, RECOVER }
enum SessionInputType { EMAIL, PASSWORD, TEXT, NUMBER }

class SessionWidgetBackground extends StatelessWidget {
  final Widget child;
  SessionWidgetBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFFf16c89),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: this.child,
    );
  }
}

class SessionInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final SessionInputType sessionInputType;
  final IconData iconData;
  final String hintText;
  final bool readOnly, caps, lastInput;
  final Function(String? value)? validator;
  SessionInputWidget({
    required this.controller,
    required this.sessionInputType,
    required this.iconData,
    required this.hintText,
    this.readOnly = false,
    this.caps = false,
    this.lastInput = false,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SessionWidgetBackground(
      child: TextFormField(
        validator: (String? value) =>
            (this.validator == null) ? null : this.validator!(value),
        keyboardType: (this.sessionInputType == SessionInputType.EMAIL)
            ? TextInputType.emailAddress
            : (this.sessionInputType == SessionInputType.PASSWORD)
                ? TextInputType.visiblePassword
                : (this.sessionInputType == SessionInputType.TEXT)
                    ? TextInputType.text
                    : TextInputType.number,
        style: Theme.of(context).textTheme.bodyText2,
        obscureText: this.sessionInputType == SessionInputType.PASSWORD,
        controller: this.controller,
        readOnly: this.readOnly,
        textCapitalization:
            this.caps ? TextCapitalization.words : TextCapitalization.none,
        textInputAction:
            (lastInput) ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () => (lastInput)
            ? FocusScope.of(context).unfocus()
            : FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            this.iconData,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontStyle: Theme.of(context).textTheme.bodyText2!.fontStyle,
            fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

class SessionButtonWidget extends StatelessWidget {
  final IconData icon;
  final String? text;
  final FitTextStyle fitTextStyle;
  final Function onPressed;

  SessionButtonWidget(
      {required this.icon,
      required this.text,
      required this.fitTextStyle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return (this.text == null)
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 15.0,
                shadowColor: Colors.black45,
                primary: Colors.white.withOpacity(0.85),
                onPrimary: Colors.grey),
            child: Icon(
              this.icon,
              color: Colors.black87,
            ),
            onPressed: () => onPressed())
        : ElevatedButton.icon(
            icon: Icon(
              this.icon,
              color: Colors.black87,
            ),
            style: ElevatedButton.styleFrom(
                elevation: 15.0,
                shadowColor: Colors.black45,
                primary: Colors.white.withOpacity(0.85),
                onPrimary: Colors.grey),
            label: FitText(text: this.text!, fitTextStyle: this.fitTextStyle),
            onPressed: () => onPressed());
  }
}

class SessionBackgroundWidget extends StatelessWidget {
  final Widget child;
  SessionBackgroundWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFf57394),
                    Color(0xFFf16183),
                    Color(0xFFe0476b),
                    Color(0xFFe53961),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                child: this.child,

                /**/
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final BooleanWrapper hidePassword = BooleanWrapper(value: true);
  final _key = GlobalKey<FormState>();
  static const double spacing = 12.0;

  LoginScreen();

  @override
  Widget build(BuildContext context) {
    return SessionBackgroundWidget(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: this._key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FitText(
                    text: 'Iniciar Sesión',
                    textAlignment: TextAlign.center,
                    fitTextStyle: FitTextStyle.H4,
                  ),
                  const SizedBox(height: 30.0),
                  SessionInputWidget(
                    controller: this._emailController,
                    sessionInputType: SessionInputType.EMAIL,
                    iconData: Icons.email_outlined,
                    hintText: 'Email',
                    validator: (String? value) {
                      return (value == null)
                          ? null
                          : (value.trim().isEmpty)
                              ? 'Por favor, ingrese un correo.'
                              : (!RegExp(".+@galileo.edu").hasMatch(value))
                                  ? "Ingresa un correo válido."
                                  : null;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  SessionInputWidget(
                    controller: this._passwordController,
                    sessionInputType: SessionInputType.PASSWORD,
                    iconData: Icons.vpn_key,
                    hintText: 'Contraseña',
                    lastInput: true,
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else
                        return (value.trim().isEmpty)
                            ? 'Por favor, ingrese una contraseña.'
                            : (value.length < 6)
                                ? "Ingrese una contraseña de al menos 6 caracteres"
                                : null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SessionButtonWidget(
                        icon: Icons.login,
                        text: 'Acceder',
                        fitTextStyle: FitTextStyle.H2,
                        onPressed: () async {
                          if (this._key.currentState!.validate()) {
                            ProgressDialog pd = ProgressDialog(
                              text: 'Espera un momento...',
                              progressDialogIndicator:
                                  ProgressDialogIndicator.CIRCULAR,
                              maxProgress: 1,
                            );
                            pd.setProgressIndicatorStyle(width: 6.0);
                            pd.showProgressDialog(context: context);

                            // Sign in
                            try {
                              UserCredential? user = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: this._emailController.text,
                                password: this._passwordController.text,
                              );

                              if (user.user!.emailVerified) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.user!.uid)
                                    .get()
                                    .then(
                                  (snapshot) {
                                    final UGUser ugUser = UGUser(
                                      name: snapshot['name'],
                                      lastName: snapshot['lastName'],
                                      email: snapshot['email'],
                                      id: snapshot['id'],
                                      faculty: snapshot['faculty'],
                                      rating: (snapshot['rating'] == null)
                                          ? null
                                          : (snapshot['rating'] as int)
                                              .toDouble(),
                                      noRatings: snapshot['noRatings'],
                                      uid: user.user!.uid,
                                    );

                                    pd.update(
                                        text: 'Espera un momento...',
                                        currentProgress: 1);
                                    pd.dismiss(context: context);
                                    Navigator.pushNamed(context, '/mainscreen',
                                        arguments: ugUser);
                                  },
                                );
                              } else {
                                pd.dismiss(context: context);
                                DialogTemplate.showMessage(
                                    context: context,
                                    message:
                                        'Por favor, valida la dirección del correo electrónico.');
                              }
                            } catch (error) {
                              pd.dismiss(context: context);
                              print(
                                  'Exception in Sign In: ${error.toString()}');
                              DialogTemplate.showMessage(
                                  context: context,
                                  message:
                                      'Correo y/o contraseña ingresadas no son válidas.');
                            }
                          } else
                            DialogTemplate.showMessage(
                                context: context,
                                message:
                                    'Por favor, ingresa credenciales válidas.');
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 12.0),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: SessionButtonWidget(
                      icon: Icons.refresh,
                      text: 'Recuperar Contraseña',
                      fitTextStyle: FitTextStyle.H3,
                      onPressed: () => Navigator.pushNamed(context, '/recover'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: SessionButtonWidget(
                      icon: Icons.person_add,
                      text: 'Registrarme',
                      fitTextStyle: FitTextStyle.H2,
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/signup')},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RecoverPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  RecoverPasswordScreen();

  static const double spacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return SessionBackgroundWidget(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: this.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FitText(
                    text: 'Recuperar\nContraseña',
                    textAlignment: TextAlign.center,
                    fitTextStyle: FitTextStyle.H4,
                  ),
                  const SizedBox(height: 30.0),
                  SessionInputWidget(
                    controller: this._emailController,
                    sessionInputType: SessionInputType.EMAIL,
                    iconData: Icons.email_outlined,
                    hintText: 'Email',
                    lastInput: true,
                    validator: (String? value) {
                      return (value == null)
                          ? null
                          : (value.trim().isEmpty)
                              ? 'Por favor, ingrese un correo.'
                              : (!RegExp(".+@galileo.edu").hasMatch(value))
                                  ? "Ingresa un correo válido."
                                  : null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SessionButtonWidget(
                      icon: Icons.send,
                      text: 'Recuperar',
                      fitTextStyle: FitTextStyle.H2,
                      onPressed: () async {
                        if (this.formKey.currentState!.validate()) {
                          ProgressDialog pd = ProgressDialog(
                              text: 'Espere un momento...',
                              progressDialogIndicator:
                                  ProgressDialogIndicator.CIRCULAR);
                          pd.setProgressIndicatorStyle(width: 6.0);
                          pd.showProgressDialog(context: context);

                          String message = "";
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: this._emailController.text)
                              .then(
                            (value) {
                              message =
                                  'Se acaba de enviar un correo con las instrucciones para recuperar la contraseña. Por favor, revise su inbox';
                            },
                          ).catchError(
                            (error) {
                              print(
                                  'Exception on Recovery Password: ${error.toString()}');
                              message =
                                  'Ocurrió un error. Por favor intenta de nuevo';
                            },
                          );

                          pd.dismiss(context: context);

                          DialogTemplate.showMessage(
                              context: context, message: message);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 12.0),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: SessionButtonWidget(
                      icon: Icons.login,
                      text: 'Iniciar Sesión',
                      fitTextStyle: FitTextStyle.H3,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final BooleanWrapper hidePassword = BooleanWrapper(value: true);
  final formKey = GlobalKey<FormState>();
  static const double spacing = 15.0;
  final faculties = [
    'FISICC',
    'FACTI',
    'FABIQ',
    'FACED',
    'FACOM',
    'FACTEDE',
    'FICON',
    'FACISA',
  ];

  SignUpScreen();

  @override
  Widget build(BuildContext context) {
    return SessionBackgroundWidget(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          FitText(
            text: 'Crear Cuenta',
            textAlignment: TextAlign.center,
            fitTextStyle: FitTextStyle.H4,
          ),
          const SizedBox(height: 30.0),
          Form(
            key: this.formKey,
            child: Column(
              children: [
                SessionInputWidget(
                  controller: this._emailController,
                  sessionInputType: SessionInputType.EMAIL,
                  iconData: Icons.email_outlined,
                  hintText: 'Email',
                  validator: (String? value) {
                    return (value == null)
                        ? null
                        : (value.trim().isEmpty)
                            ? 'Por favor, ingrese un correo.'
                            : (!RegExp(".+@galileo.edu").hasMatch(value))
                                ? "Ingresa un correo válido."
                                : null;
                  },
                ),
                const SizedBox(height: spacing),
                SessionInputWidget(
                    controller: this._passwordController,
                    sessionInputType: SessionInputType.PASSWORD,
                    iconData: Icons.vpn_key,
                    hintText: 'Contraseña',
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else
                        return (value.trim().isEmpty)
                            ? 'Por favor, ingrese una contraseña.'
                            : (value.length < 6)
                                ? "Ingrese una contraseña de al menos 6 caracteres"
                                : null;
                    }),
                const SizedBox(height: spacing),
                SessionInputWidget(
                    controller: this._nameController,
                    sessionInputType: SessionInputType.TEXT,
                    iconData: Icons.person,
                    hintText: 'Nombre(s)',
                    caps: true,
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else
                        return (value.trim().isEmpty)
                            ? 'Por favor, ingrese su nombre'
                            : null;
                    }),
                const SizedBox(height: spacing),
                SessionInputWidget(
                    controller: this._lastNameController,
                    sessionInputType: SessionInputType.TEXT,
                    iconData: Icons.person,
                    hintText: 'Apellido(s)',
                    caps: true,
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else
                        return (value.trim().isEmpty)
                            ? 'Por favor, ingrese su apellido'
                            : null;
                    }),
                const SizedBox(height: spacing),
                SessionInputWidget(
                    controller: this._idController,
                    sessionInputType: SessionInputType.NUMBER,
                    iconData: Icons.featured_video,
                    hintText: 'Carnet',
                    lastInput: true,
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else
                        return (value.trim().isEmpty)
                            ? 'Por favor, ingrese su carnet'
                            : null;
                    }),
                const SizedBox(height: spacing),
                ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  title: SessionInputWidget(
                      controller: this._facultyController,
                      sessionInputType: SessionInputType.TEXT,
                      iconData: Icons.house,
                      hintText: 'Facultad',
                      readOnly: true,
                      lastInput: true,
                      validator: (String? value) {
                        if (value == null)
                          return null;
                        else
                          return (value.trim().isEmpty)
                              ? 'Por favor, ingrese su facultad'
                              : null;
                      }),
                  trailing: SessionButtonWidget(
                    icon: Icons.search,
                    text: null,
                    fitTextStyle: FitTextStyle.H1,
                    onPressed: () => {
                      DialogTemplate.showSelectOptions(
                        context: context,
                        title: 'Opciones',
                        options: const [0, 1, 2, 3, 4, 5, 6, 7],
                        captions: this.faculties,
                        aftermath: (index) => this._facultyController.text =
                            this.faculties[index],
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SessionButtonWidget(
                icon: Icons.refresh,
                text: 'Reset',
                fitTextStyle: FitTextStyle.H2,
                onPressed: () {
                  this._emailController.text = '';
                  this._passwordController.text = '';
                  this._nameController.text = '';
                  this._lastNameController.text = '';
                  this._idController.text = '';
                  this._facultyController.text = '';
                },
              ),
              SessionButtonWidget(
                icon: Icons.send,
                text: 'Registrarme',
                fitTextStyle: FitTextStyle.H3,
                onPressed: () async {
                  String message = '';
                  if (this.formKey.currentState!.validate()) {
                    // Pedir Confirmación
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return BinaryAlert(
                            message:
                                '¿Los datos son los correctos?\nSolo podrás configurar tu contraseña.',
                            title: 'Aviso');
                      },
                    ).then(
                      (value) async {
                        UserCredential? person;
                        if (value) {
                          ProgressDialog pd = ProgressDialog(
                            text: 'Creando usuario...',
                            progressDialogIndicator:
                                ProgressDialogIndicator.CIRCULAR,
                            showPercentage: false,
                            maxProgress: 2,
                          );
                          pd.setProgressIndicatorStyle(width: 6.0);
                          pd.showProgressDialog(context: context);
                          // Creating Student account
                          try {
                            // Attempting to create a profile
                            person = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: this._emailController.text,
                              password: this._passwordController.text,
                            );
                            person.user!.sendEmailVerification();

                            // Make sure to insert the document
                            pd.update(
                                text: 'Creando usuario...', currentProgress: 1);
                            while (true) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(person.user!.uid)
                                    .set(
                                  {
                                    'email': this._emailController.text.trim(),
                                    'id': int.parse(
                                        this._idController.text.trim()),
                                    'name': this._nameController.text.trim(),
                                    'lastName':
                                        this._lastNameController.text.trim(),
                                    'rating': null,
                                    'noRatings': 0,
                                    'faculty':
                                        this._facultyController.text.trim(),
                                  },
                                );
                                break;
                              } catch (error) {
                                print(
                                    'Error in Inserting Document: ${error.toString()}');
                              }
                            }
                            pd.update(
                                text: 'Creando usuario...', currentProgress: 2);
                            message = 'La creación de su usuario fue exitoso';
                            pd.dismiss(context: context);
                          } catch (error) {
                            print(
                                'Error in Sign Up Authentication: ${error.toString()}');
                            message =
                                'Ocurrió un error durante la creación de su usuario. Por favor intente de nuevo.\n\n'
                                'Si el error persiste, contacte al equipo usando el siguiente correo: ';
                          }

                          DialogTemplate.showMessage(
                              context: context, message: message);
                        }
                      },
                    );
                  } else {
                    message = 'Por favor, ingresa credenciales válidas.';
                    DialogTemplate.showMessage(
                        context: context, message: message);
                  }
                },
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Divider(
              color: Colors.black54,
            ),
          ),
          SessionButtonWidget(
            icon: Icons.login,
            text: 'Iniciar Sesión',
            fitTextStyle: FitTextStyle.H3,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class SP2DemoOneScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF26c6da);
  final Color primaryLightColor = Color(0xFF6ff9ff);
  final Color primaryDarkColor = Color(0xFF0095a8);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: this.primaryColor,
          title: Text(
            'Flutter SP2',
            style: Theme.of(context).textTheme.headline2,
          ),
          leading: Icon(
            Icons.home,
            color: Colors.black54,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Título',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                  '\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                  '\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                  '\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.settings_cell,
                  color: this.primaryDarkColor,
                ),
                title: Text(
                  'Texto 1',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Icon(Icons.add, color: this.primaryDarkColor),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.desktop_windows,
                  color: this.primaryDarkColor,
                ),
                title: Text(
                  'Texto 2',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Icon(Icons.add, color: this.primaryDarkColor),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
            FlutterLogo(
              size: 100.0,
            ),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton.icon(
              onPressed: () {
                print('¡Has presionado el boton!');
              },
              icon: Icon(Icons.info),
              label: Text(
                'Presiona aquí',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: this.primaryDarkColor,
                onPrimary: this.primaryLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
