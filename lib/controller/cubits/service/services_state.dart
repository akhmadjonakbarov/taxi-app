part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<Service> services;
  ServicesLoaded({required this.services});
}

class ServicesError extends ServicesState {
  final String errorMessage;
  ServicesError({required this.errorMessage});
}
