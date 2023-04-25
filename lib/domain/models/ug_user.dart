// Utils
import '../../utils/constants.dart';

class UGUser {
  String _names, _lastNames, _email;
  String? _firestoreId;
  int _id;
  Faculty _faculty;
  double? _rating;

  UGUser(
      {required String names,
      required String lastNames,
      required String email,
      required int id,
      required int faculty,
      double? rating,
      String? firestoreId})
      : _names = names,
        _lastNames = lastNames,
        _email = email,
        _faculty = UGFaculties.mapIntToEnum(faculty: faculty),
        _id = id,
        _rating = rating,
        _firestoreId = firestoreId;

  // Setters
  set names(value) => _names = value;
  set lastNames(value) => _lastNames = value;
  set email(value) => _email = value;
  set faculty(value) => _faculty = value;
  set id(value) => _id = value;
  set rating(value) => _rating = value;

  // Getters
  String? get firestoreId => _firestoreId;
  String get names => _names;
  String get lastNames => _lastNames;
  String get email => _email;
  int get facultyIndex => _faculty.index;
  String get faculty => UGFaculties.mapEnumToString(faculty: _faculty);
  int get id => _id;
  double? get rating => _rating;

  // Complex Getters
  String get fullName => "$_names $_lastNames";

  static UGUser mapToModel({required dynamic snapshot}) => UGUser(
        names: snapshot["name"],
        lastNames: snapshot["lastNames"],
        email: snapshot["email"],
        faculty: snapshot["faculty"],
        id: snapshot["id"],
        rating: snapshot["rating"],
        firestoreId: snapshot.id,
      );

  Map<String, dynamic> toMap() => {
        "name": _names,
        "lastNames": _lastNames,
        "email": _email,
        "faculty": _faculty.index,
        "id": _id,
        "rating": _rating,
      };
}
