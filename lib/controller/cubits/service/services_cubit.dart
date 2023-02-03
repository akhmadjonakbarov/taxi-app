// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../models/models.dart';
import '../../api/constants.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());
  Map<String, String> headers = {
    'Server': 'WSGIServer/0.2 CPython/3.10.5',
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Allow': 'POST, PATCH, DELETE, OPTIONS',
  };

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
              fromWhere: service['from_where'],
              toWhere: service['to_where'],
              carType: service['car_type'],
              servicePrice: service['service_price'],
              phoneNumber: service['phone_number'],
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
    required User user,
  }) async {
    final addUrl =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cudservicesEndPoint);
    Map<String, dynamic> body = {
      "from_where": from_where,
      "to_where": to_where,
      "service_price": service_price,
      "leaving_time": DateFormat("yyyy-MM-d").format(leaving_time),
      "phone_number": phone_number,
      "car_type": "nxx",
    };
    headers["Authorization"] = "Token $accessToken";
    try {
      http.Response response =
          await http.post(addUrl, body: jsonEncode(body), headers: headers);
      Map<String, dynamic> resBody = jsonDecode(response.body);
      Service service = Service(
        id: resBody['id'],
        fromWhere: resBody['from_where'],
        toWhere: resBody['to_where'],
        carType: resBody['car_type'],
        phoneNumber: resBody['phone_number'],
        servicePrice: resBody['service_price'],
        leavingTime: resBody['leaving_time'],
        usedId: resBody['user']['id'],
        firstName: resBody['user']['first_name'],
      );
      emit(ServicesAdded(service: service));
      filteredUserServices(userId: user.id);
    } catch (error) {
      emit(
        ServicesError(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void updated({
    required String accessToken,
    required int id,
    required String from_where,
    required String to_where,
    required double service_price,
    required DateTime leaving_time,
    required String phone_number,
    required User user,
  }) async {
    final updateUrl =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cudservicesEndPoint);
    Map<String, dynamic> body = {
      "id": id,
      "from_where": from_where,
      "to_where": to_where,
      "service_price": service_price,
      "leaving_time": leaving_time.toString(),
      "phone_number": phone_number,
      "car_type": "nxx",
    };

    headers["Authorization"] = "Token $accessToken";

    try {
      http.Response response =
          await http.patch(updateUrl, body: jsonEncode(body), headers: headers);

      Map<String, dynamic> resBody = jsonDecode(response.body);

      Service service = Service(
        id: resBody['id'],
        fromWhere: resBody['from_where'],
        toWhere: resBody['to_where'],
        carType: resBody['car_type'],
        phoneNumber: resBody['phone_number'],
        servicePrice: resBody['service_price'],
        leavingTime: resBody['leaving_time'],
        usedId: user.id,
        firstName: user.firstName,
      );
      emit(ServicesAdded(service: service));
    } catch (error) {
      emit(
        ServicesError(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void deleteService(
      {required String accessToken,
      required int serviceId,
      required userId}) async {
    List<Service> services = [];
    final deleteUrl = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.cudservicesEndPoint}?deleteId=$serviceId");
    headers["Authorization"] = "Token $accessToken";
    try {
      await http.delete(deleteUrl, headers: headers);

      filteredUserServices(userId: userId);

      emit(FilteresUserServices(services: services));
    } catch (error) {
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
              fromWhere: service['from_where'],
              toWhere: service['to_where'],
              carType: service['car_type'],
              servicePrice: service['service_price'],
              phoneNumber: service['phone_number'],
              usedId: service['user']['id'],
              firstName: service['user']['first_name'],
              leavingTime: service['leaving_time']),
        );
      }

      List<Service> filteredService = [];

      for (var service in services) {
        DateTime serviceDateTime = DateTime.parse(service.leavingTime);
        if (service.fromWhere.trim().startsWith(fromWhere) &&
            service.toWhere.trim().startsWith(toWhere) &&
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

  Future<void> filteredUserServices({required int userId}) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.serviceEndPoint);
    List<Service> services = [];
    List<Service> userServices = [];
    try {
      emit(ServicesInitial());
      final response = await http.get(url);
      var data = await jsonDecode(response.body);
      for (Map<String, dynamic> service in data) {
        services.add(
          Service(
              id: service['id'],
              fromWhere: service['from_where'],
              toWhere: service['to_where'],
              carType: service['car_type'],
              servicePrice: service['service_price'],
              phoneNumber: service['phone_number'],
              usedId: service['user']['id'],
              firstName: service['user']['first_name'],
              leavingTime: service['leaving_time']),
        );
      }
      for (Service service in services) {
        if (service.usedId == userId) {
          userServices.add(service);
        }
      }

      emit(FilteresUserServices(services: userServices));
    } catch (e) {
      emit(
        ServicesError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<Service> getService({required int serviceId}) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.serviceEndPoint);
    List services = [];
    late var resultService;
    try {
      final response = await http.get(url);
      var data = await jsonDecode(response.body);
      for (Map<String, dynamic> service in data) {
        services.add(
          Service(
              id: service['id'],
              fromWhere: service['from_where'],
              toWhere: service['to_where'],
              carType: service['car_type'],
              servicePrice: service['service_price'],
              phoneNumber: service['phone_number'],
              usedId: service['user']['id'],
              firstName: service['user']['first_name'],
              leavingTime: service['leaving_time']),
        );
      }
      for (Service service in services) {
        if (service.id == serviceId) {
          resultService = service;
          break;
        }
      }
    } catch (e) {
      rethrow;
    }
    return resultService;
  }
}
