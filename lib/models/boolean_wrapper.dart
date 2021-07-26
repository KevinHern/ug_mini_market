import 'package:flutter/material.dart';

class BooleanWrapper with ChangeNotifier {
  late bool _boolean;

  BooleanWrapper({required bool value}) {
    this._boolean = value;
  }

  bool get value => this._boolean;
  set value(bool newValue) {
    this._boolean = newValue;
    notifyListeners();
  }

  void invertValue() {
    this._boolean = !this._boolean;
    notifyListeners();
  }
}
