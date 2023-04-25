// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Widgets
import 'form_field_filled.dart';

class SingleLineInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String labelText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final bool readOnly, optionalField;

  const SingleLineInputField({
    required this.controller,
    required this.textInputAction,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.optionalField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldFilled(
      controller: controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: textInputAction,
      validator: (String? value) {
        if (optionalField) {
          return null;
        } else if (value == null || value.isEmpty) {
          return 'Complete el campo';
        }
        return null;
      },
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLines: 1,
    );
  }
}

class MultiLineInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final bool readOnly, optionalField;

  const MultiLineInputField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.optionalField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldFilled(
      controller: controller,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      validator: (String? value) {
        if (optionalField) {
          return null;
        } else if (value == null || value.isEmpty) {
          return 'Complete el campo';
        }
        return null;
      },
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLines: null,
    );
  }
}

class IntegerInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final Function(String? value) validator;
  final String labelText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final int? maxLength;
  final bool readOnly, optionalField;

  const IntegerInputField({
    required this.controller,
    required this.textInputAction,
    required this.validator,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.readOnly = false,
    this.optionalField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldFilled(
      controller: controller,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      validator: (String? value) {
        if (optionalField) {
          return null;
        } else {
          return validator(value);
        }
      },
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLines: 1,
      maxLength: maxLength,
      readOnly: readOnly,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}

class DecimalInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String labelText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final bool readOnly, optionalField;

  const DecimalInputField({
    required this.controller,
    required this.textInputAction,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.optionalField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldFilled(
      controller: controller,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      validator: (String? value) {
        if (optionalField) {
          return null;
        } else if (value == null || value.isEmpty) {
          return 'Complete el campo';
        } else {
          return null;
        }
      },
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLines: 1,
      readOnly: readOnly,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}

class NameInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String labelText;
  final bool readOnly;

  const NameInputField({
    required this.controller,
    required this.textInputAction,
    required this.labelText,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldFilled(
      controller: controller,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: textInputAction,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Complete el campo';
        }
        return null;
      },
      labelText: labelText,
      prefixIcon: Icon(Icons.person_rounded),
      maxLines: 1,
      readOnly: readOnly,
    );
  }
}

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final Function(String? value) validator;
  final bool readOnly;

  const EmailInputField({
    required this.controller,
    required this.textInputAction,
    required this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldFilled(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      validator: (String? value) {
        if (value == null ||
            value.isEmpty ||
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@galileo\.edu")
                .hasMatch(value)) {
          return 'Correo electrónico inválido';
        }
        return null;
      },
      labelText: 'Correo Electrónico',
      prefixIcon: Icon(Icons.email_rounded),
      maxLines: 1,
      readOnly: readOnly,
    );
  }
}
