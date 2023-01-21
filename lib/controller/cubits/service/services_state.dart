part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<Service> services;
  ServicesLoaded({required this.services});
}

class FilteresUserServices extends ServicesState {
  final List<Service> services;
  FilteresUserServices({required this.services});
}

class ServicesAdded extends ServicesState {
  final Service service;
  ServicesAdded({required this.service});
}

class ServicesDeleted extends ServicesState {}

class ServicesUpdated extends ServicesState {}

class ServicesError extends ServicesState {
  final String errorMessage;
  ServicesError({required this.errorMessage});
}
