class UGProduct {
  String _name, _description, _details;
  List<String> _categories;
  int _quantity;
  double _price;
  bool _negotiable;
  String? _firestoreId;

  UGProduct(
      {required String name,
      required String description,
      required String details,
      required List<String> categories,
      required int quantity,
      required double price,
      required bool negotiable,
      String? firestoreId})
      : _name = name,
        _description = description,
        _details = details,
        _categories = categories,
        _quantity = quantity,
        _price = price,
        _negotiable = negotiable,
        _firestoreId = firestoreId;

  // Setters
  set name(value) => _name = value;
  set description(value) => _description = value;
  set details(value) => _details = value;
  set categories(value) => _categories = value;
  set quantity(value) => _quantity = value;
  set price(value) => _price = value;
  set negotiable(value) => _negotiable = value;

  // Getters
  String get name => _name;
  String get description => _description;
  String get details => _details;
  List<String> get categories => _categories;
  int get quantity => _quantity;
  double get price => _price;
  bool get negotiable => _negotiable;
  int get negotiableInt => _negotiable ? 1 : 0;

  // Complex Getters
}
