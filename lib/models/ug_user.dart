/*
User Model:
{
  Id: <id>
  name: <String>
  lastName: <String>
  email: <String>
  rating: <double> or null
}
 */

class UGUser {
  String name, lastName, email, faculty, uid;
  int id, noRatings;
  double? rating;
  UGUser(
      {required this.name,
      required this.lastName,
      required this.email,
      required this.id,
      required this.faculty,
      required this.rating,
      required this.noRatings,
      required this.uid});
}
