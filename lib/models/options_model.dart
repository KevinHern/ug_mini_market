import 'package:flutter/material.dart';

class OptionsModel with ChangeNotifier {
  late final TextEditingController _filterController;

  OptionsModel({String initialText = ''})
      : this._filterController = TextEditingController(text: initialText);

  TextEditingController get filterController => this._filterController;

  void setText({required String value}) {
    this._filterController.text = value;
    notifyListeners();
  }
}
