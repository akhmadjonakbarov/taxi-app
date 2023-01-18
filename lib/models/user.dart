class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String token;
  List<dynamic> services;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.token,
    required this.services,
  });
}
