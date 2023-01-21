// ignore_for_file: public_member_api_docs, sort_constructors_first

class Service {
  final int id;
  final String fromWhere;
  final String toWhere;
  final String carType;
  final double servicePrice;
  final String phoneNumber;
  final int usedId;
  final String firstName;
  late final String leavingTime;
  Service({
    required this.id,
    required this.fromWhere,
    required this.toWhere,
    required this.carType,
    required this.servicePrice,
    required this.phoneNumber,
    required this.usedId,
    required this.firstName,
    required this.leavingTime,
  });
}
