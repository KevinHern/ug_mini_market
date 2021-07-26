// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Models
import 'package:ug_mini_market/models/boolean_wrapper.dart';

// Templates
import 'package:ug_mini_market/templates/dialog_template.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({
    Key? key,
    required this.emailController,
    this.readOnly = false,
    this.lastInput = false,
  }) : super(key: key);

  final TextEditingController emailController;
  final bool readOnly;
  final bool lastInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: "Correo",
      ),
      controller: emailController,
      validator: (String? value) {
        return (value == null)
            ? null
            : (value.trim().isEmpty)
                ? 'Por favor, ingrese un correo.'
                : (!RegExp(".+@[a-zA-Z]+.[a-zA-Z]+").hasMatch(value))
                    ? "Ingresa un correo válido."
                    : null;
      },
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      readOnly: readOnly,
      textInputAction:
          (lastInput) ? TextInputAction.done : TextInputAction.next,
      onEditingComplete: () => (lastInput)
          ? FocusScope.of(context).unfocus()
          : FocusScope.of(context).nextFocus(),
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    required this.controllers,
    required this.booleanWrapper,
    required this.onPressed,
    this.isConfirmation = false,
    this.lastInput = false,
  }) : super(key: key);

  final List<TextEditingController> controllers;
  final BooleanWrapper booleanWrapper;
  final Function onPressed;
  final bool isConfirmation;
  final bool lastInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: IconButton(
            icon: Icon((booleanWrapper.value)
                ? Icons.visibility_off
                : Icons.visibility),
            onPressed: () => onPressed),
        labelText: 'Contraseña',
      ),
      controller: controllers[0],
      validator: (String? value) {
        if (value == null)
          return null;
        else {
          if (!isConfirmation) {
            return (value.trim().isEmpty)
                ? 'Por favor, ingrese una contraseña.'
                : (value.length < 6)
                    ? "Ingrese una contraseña de al menos 6 caracteres"
                    : null;
          } else {
            return (controllers[0].text != controllers[1].text)
                ? 'Las contraseñas no coinciden'
                : null;
          }
        }
      },
      textCapitalization: TextCapitalization.none,
      obscureText: booleanWrapper.value,
      textInputAction:
          (lastInput) ? TextInputAction.done : TextInputAction.next,
      onEditingComplete: () => (lastInput)
          ? FocusScope.of(context).unfocus()
          : FocusScope.of(context).nextFocus(),
    );
  }
}

class InputSingleText extends StatelessWidget {
  const InputSingleText({
    Key? key,
    required this.caption,
    required this.icon,
    required this.controller,
    this.caps = true,
    this.readOnly = false,
    this.lastInput = false,
  }) : super(key: key);

  final String caption;
  final IconData icon;
  final TextEditingController controller;
  final bool caps;
  final bool readOnly;
  final bool lastInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: caption,
      ),
      controller: controller,
      validator: (String? value) {
        if (value == null)
          return null;
        else
          return (value.trim().isEmpty) ? 'Por favor, llene el campo' : null;
      },
      textCapitalization:
          (caps) ? TextCapitalization.sentences : TextCapitalization.none,
      readOnly: readOnly,
      textInputAction:
          (lastInput) ? TextInputAction.done : TextInputAction.next,
    );
  }
}

class InputMultiText extends StatelessWidget {
  const InputMultiText({
    Key? key,
    required this.caption,
    required this.icon,
    required this.controller,
    this.caps = true,
    this.lastInput = false,
  }) : super(key: key);

  final String caption;
  final IconData icon;
  final TextEditingController controller;
  final bool caps;
  final bool lastInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: caption,
      ),
      controller: controller,
      validator: (String? value) {
        if (value == null)
          return null;
        else
          return (value.trim().isEmpty) ? 'Por favor, llene el campo' : null;
      },
      textCapitalization:
          (caps) ? TextCapitalization.sentences : TextCapitalization.none,
      maxLines: null,
      textInputAction:
          (lastInput) ? TextInputAction.done : TextInputAction.newline,
    );
  }
}

enum InputNumberType { PRICE, INT_POSITIVE, INT_NEGATIVES, GENERAL }

class InputNumber extends StatelessWidget {
  const InputNumber({
    Key? key,
    required this.caption,
    required this.icon,
    required this.controller,
    this.inputFormatter = InputNumberType.INT_POSITIVE,
    this.mustLimit = false,
    this.numberLimit = 8,
    this.acceptNegatives = true,
    this.readOnly = false,
    this.lastInput = false,
  }) : super(key: key);

  final InputNumberType inputFormatter;
  final String caption;
  final IconData icon;
  final TextEditingController controller;
  final bool mustLimit;
  final int numberLimit;
  final bool acceptNegatives;
  final bool readOnly;
  final bool lastInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: caption,
        ),
        validator: (String? value) {
          if (value == null)
            return null;
          else
            return (value.trim().isEmpty)
                ? 'Por favor, llene el campo.'
                : (!acceptNegatives && value.contains('-'))
                    ? "Solo números positivos."
                    : null;
        },
        inputFormatters: (this.inputFormatter == InputNumberType.INT_POSITIVE)
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(
                    (this.mustLimit) ? numberLimit : null),
              ]
            : (this.inputFormatter == InputNumberType.INT_NEGATIVES)
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?(\d+)')),
                  ]
                : (this.inputFormatter == InputNumberType.INT_NEGATIVES)
                    ? [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}')),
                      ]
                    : (this.inputFormatter == InputNumberType.PRICE)
                        ? [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}')),
                          ]
                        : [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(-?)(\d+)(\.?)(\d+)')),
                          ],
        controller: controller,
        readOnly: readOnly,
        textInputAction:
            (lastInput) ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () => (lastInput)
            ? FocusScope.of(context).unfocus()
            : FocusScope.of(context).nextFocus());
  }
}

class InputDate extends StatelessWidget {
  const InputDate({
    Key? key,
    required this.caption,
    required this.icon,
    required this.controller,
    required this.function,
  }) : super(key: key);

  final String caption;
  final IconData icon;
  final TextEditingController controller;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today),
          labelText: 'Fecha',
        ),
        validator: (String? value) {
          if (value == null)
            return null;
          else
            return (value.trim().isEmpty)
                ? 'Por favor, escoge una fecha.'
                : null;
        },
        controller: controller,
        readOnly: true,
      ),
      trailing: ElevatedButton(
        onPressed: () async {
          DateTime? date = await showDatePicker(
            context: context,
            firstDate: DateTime(DateTime.now().year - 90),
            lastDate: DateTime(DateTime.now().year + 1),
            initialDate: DateTime.now(),
            initialEntryMode: DatePickerEntryMode.calendar,
          );
          if (date != null) {
            controller.text = DateFormat('dd/MM/yyyy').format(date);
            function();
          }
        },
        child: Icon(
          Icons.edit,
          color: Colors.white70,
        ),
      ),
    );
  }
}

class InputTime extends StatelessWidget {
  const InputTime({
    Key? key,
    required this.caption,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  final String caption;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.access_time),
          labelText: 'Hora',
        ),
        validator: (String? value) {
          if (value == null)
            return null;
          else
            return (value.trim().isEmpty)
                ? 'Por favor, escoge una hora.'
                : null;
        },
        controller: controller,
        readOnly: true,
      ),
      trailing: ElevatedButton(
        onPressed: () async {
          TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (time == null) time = TimeOfDay.now();
          controller.text =
              (time.hour < 10) ? "0${time.hour}:" : "${time.hour}:";
          controller.text +=
              (time.minute < 10) ? "0${time.minute}" : "${time.minute}";
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class InputSwitch extends StatelessWidget {
  const InputSwitch({
    Key? key,
    required this.caption,
    required this.icon,
    required this.booleanWrapper,
  }) : super(key: key);

  final String caption;
  final IconData icon;
  final BooleanWrapper booleanWrapper;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: double.infinity,
        child: Icon(icon),
      ),
      title: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(
          caption,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.left,
        ),
      ),
      trailing: Switch(
        value: booleanWrapper.value,
        onChanged: (value) {
          booleanWrapper.value = value;
        },
      ),
    );
  }
}

class InputOptions extends StatelessWidget {
  const InputOptions({
    Key? key,
    required this.caption,
    required this.icon,
    required this.controller,
    required this.captions,
  }) : super(key: key);

  final String caption;
  final IconData icon;
  final TextEditingController controller;
  final List captions;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: caption,
        ),
        validator: (String? value) {
          if (value == null)
            return null;
          else
            return (value.trim().isEmpty)
                ? 'Por favor, escoge una opción.'
                : null;
        },
        controller: this.controller,
        readOnly: false,
      ),
      trailing: ElevatedButton(
        onPressed: () async {
          final List<int> options = [];
          for (int i = 0; i < captions.length; i++) options.add(i);
          await DialogTemplate.showSelectOptions(
            context: context,
            title: 'Opciones',
            options: options,
            captions: captions,
            aftermath: (index) {
              this.controller.text = captions[index];
            },
            areRoutingOptions: false,
          );
        },
        child: Icon(
          Icons.edit,
          color: Colors.white70,
        ),
      ),
    );
  }
}

class InputAddToList extends StatelessWidget {
  const InputAddToList({
    Key? key,
    required this.caption,
    required this.icon,
    required this.controller,
    required this.values,
    required this.trailingButton,
    this.lastInput = false,
  }) : super(key: key);

  final String caption;
  final IconData icon;
  final TextEditingController controller;
  final List<String> values;
  final Widget trailingButton;
  final bool lastInput;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      title: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: 'Agregar Sección',
        ),
        textCapitalization: TextCapitalization.words,
        controller: controller,
        textInputAction:
            (lastInput) ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () => (lastInput)
            ? FocusScope.of(context).unfocus()
            : FocusScope.of(context).nextFocus(),
      ),
      trailing: trailingButton,
    );
  }
}
