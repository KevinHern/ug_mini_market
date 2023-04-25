// Basic Imports
import 'package:flutter/material.dart';

class ProductsFilter {
  final List<String> categories, faculties;
  bool displayAsBlocks;
  final TextEditingController searchBarController;

  ProductsFilter(
      {this.categories = const [],
      this.faculties = const [],
      this.displayAsBlocks = false})
      : searchBarController = TextEditingController();

  // Getters
  int get displayAsBlocksInt => displayAsBlocks ? 1 : 0;
}
