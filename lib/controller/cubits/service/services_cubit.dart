// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../models/models.dart';
import '../../api/constants.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());

  Future<void> getServices() async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.serviceEndPoint);
    List<Service> services = [];
    try {
      emit(ServicesInitial());
      final response = await http.get(url);
      var data = await jsonDecode(response.body);
      for (Map<String, dynamic> service in data) {
        services.add(
          Service(
              id: service['id'],
              numberOfPeople: 0,
              fromWhere: service['from_where'],
              toWhere: service['to_where'],
              carType: service['car_type'],
              createdOn: "",
              updatedOn: "",
              usedId: service['user']['id'],
              firstName: service['user']['first_name'],
              leavingTime: service['leaving_time']),
        );
      }
      emit(ServicesLoaded(services: services));
    } catch (e) {
      emit(ServicesError(errorMessage: e.toString()));
    }
  }

  void add({
    required String accessToken,
    required String from_where,
    required String to_where,
    required double service_price,
    required DateTime leaving_time,
    required String phone_number,
  }) async {
    final addUrl =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cudservicesEndPoint);
    Map<String, dynamic> body = {
      "from_where": from_where,
      "to_where": to_where,
      // "service_price": service_price,
      "leaving_time": leaving_time.toString(),
      "phone_number": phone_number,
      "car_type": "nxx",
    };
    try {
      http.Response response = await http.post(addUrl,
          body: body, headers: {"Authorization": "Bearer $accessToken"});
      print(response);
    } catch (error) {
      print(error.toString());
      emit(
        ServicesError(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void clearService() {
    emit(ServicesInitial());
  }

  void filterService({
    required String fromWhere,
    required String toWhere,
    required DateTime dateTime,
  }) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.serviceEndPoint);
    List<Service> services = [];
    try {
      emit(ServicesLoading());
      final response = await http.get(url);
      var data = await jsonDecode(response.body);
      for (Map<String, dynamic> service in data) {
        services.add(
          Service(
              id: service['id'],
              numberOfPeople: 0,
              fromWhere: service['from_where'],
              toWhere: service['to_where'],
              carType: service['car_type'],
              createdOn: "",
              updatedOn: "",
              usedId: service['user']['id'],
              firstName: service['user']['first_name'],
              leavingTime: service['leaving_time']),
        );
      }

      List<Service> filteredService = [];

      for (var service in services) {
        DateTime serviceDateTime = DateTime.parse(service.leavingTime);
        if (service.fromWhere.trim() == fromWhere &&
            service.toWhere.trim() == toWhere &&
            DateTime(serviceDateTime.year, serviceDateTime.month,
                    serviceDateTime.day) ==
                DateTime(
                  dateTime.year,
                  dateTime.month,
                  dateTime.day,
                )) {
          filteredService.add(service);
        }
      }
      emit(
        ServicesLoaded(services: filteredService),
      );
    } catch (e) {
      emit(ServicesError(errorMessage: e.toString()));
    }
  }
}

void main(List<String> args) {
  ServicesCubit servicesCubit = ServicesCubit();
  servicesCubit.getServices();
}
