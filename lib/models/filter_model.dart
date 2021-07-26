import 'package:flutter/material.dart';

class FilterModel with ChangeNotifier {
  String _caption;
  int _option;

  String get caption => _caption;
  int get option => _option;

  FilterModel({required String caption, required int option})
      : this._caption = caption,
        this._option = option;

  void setFilter({required String caption, required int option}) {
    this._caption = caption;
    this._option = option;
    notifyListeners();
  }
}
