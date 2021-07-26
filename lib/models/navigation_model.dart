// Basic Imports
import 'package:flutter/material.dart';
import 'dart:collection';

class Stack<T> {
  final _stack = Queue<T>();

  int get length => this._stack.length;

  bool canPop() => this._stack.isNotEmpty;

  void clearStack() {
    while (this._stack.isNotEmpty) {
      this._stack.removeLast();
    }
  }

  void push(T element) {
    this._stack.addLast(element);
  }

  T pop() {
    T lastElement = this._stack.last;
    this._stack.removeLast();
    return lastElement;
  }

  T peak() => this._stack.last;
}

class NavigationModel extends ChangeNotifier {
  static const screens = [
    '/profile',
    '/inbox',
    '/products',
    '/market',
    '/feedback',
    // Sub Routes
    '/myproduct',
    '/product',
    '/rating',
  ];
  Stack<String> _routeManager = Stack<String>();
  List<dynamic> _arguments;
  NavigationModel(
      {required String currentScreen, required List<dynamic> arguments})
      : assert(currentScreen.contains('/')),
        this._arguments = arguments {
    this._routeManager.push(currentScreen);
  }

  String get currentScreen => this._routeManager.peak();
  List<dynamic> get arguments => this._arguments;
  int get currentLevel => this._routeManager.length;

  void popRoute() {
    print(this._routeManager.pop());
    notifyListeners();
  }

  void pushRoute({required String route, @required List<dynamic>? arguments}) {
    this._arguments = (arguments == null) ? this._arguments : arguments;
    this._routeManager.push(route);
    print(route);
    notifyListeners();
  }

  /* Complex Routing Functions */

  void popUntil(String route) {
    while (this._routeManager.peak() != route) {
      this._routeManager.pop();
    }
    notifyListeners();
  }

  void popThenPush(
      {required String route, @required List<dynamic>? arguments}) {
    this._routeManager.pop();
    this.pushRoute(route: route, arguments: arguments);
    notifyListeners();
  }

  void clearThenPush(
      {required String route, @required List<dynamic>? arguments}) {
    this._routeManager.clearStack();
    this.pushRoute(route: route, arguments: arguments);
    notifyListeners();
  }
}
