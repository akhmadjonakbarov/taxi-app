// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:taxi_app/models/models.dart';

import '../../api/constants.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Map<String, String> headers = {"content-type": "application/json"};
  late User _user;

  Future<void> userLogin(
      {required String username, required String password}) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndPoint);
    final getUserUrl =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndPoint);

    if (username.isNotEmpty && password.isNotEmpty) {
      String data = jsonEncode({"username": username, "password": password});
      try {
        emit(UserInitial());
        http.Response response =
            await http.post(url, body: data, headers: headers);
        emit(UserLoading());
        updateCookie(response);
        final resData = await jsonDecode(response.body);
        String accessToken = await resData["user_info"]["access"];
        http.Response resUser = await http.get(
          getUserUrl,
          headers: {"Authorization": "Bearer $accessToken"},
        );
        final userData = jsonDecode(resUser.body);
        _user = User(
          id: userData["id"],
          firstName: userData["first_name"],
          lastName: userData["last_name"],
          phoneNumber: userData["phone_number"],
          token: accessToken,
          services: userData["services"],
        );
        emit(UserLogin(user: _user));
      } catch (e) {
        emit(
          UserError(errorMsg: e.toString()),
        );
      }
    }
  }

  Future<void> userLogOut() async {
    try {
      _user = User(
        id: 0,
        firstName: "",
        lastName: "",
        phoneNumber: "",
        token: "",
        services: [],
      );
      emit(UserLogout(user: _user));
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  User get user {
    User userNull = User(
      id: 0,
      firstName: "",
      lastName: "",
      phoneNumber: "",
      token: "",
      services: [],
    );
    if (_user.firstName.isNotEmpty) {
      return _user;
    }
    return userNull;
  }

  List<Service> get userServices {
    User getUser = user;
    List<Service> userServices = [];
    for (var service in getUser.services) {
      userServices.add(
        Service(
          id: service['id'],
          fromWhere: service['from_where'],
          toWhere: service['to_where'],
          carType: service['car_type'],
          servicePrice: service['service_price'],
          phoneNumber: service['phone_number'],
          usedId: service['user']['id'],
          firstName: service['user']['first_name'],
          leavingTime: service['leaving_time'],
        ),
      );
    }
    return userServices;
  }

  Service getService({required int serviceId}) {
    List<Service> services = userServices;
    return services.firstWhere((element) => element.id == serviceId);
  }
}

void main(List<String> args) {
  UserCubit userCubit = UserCubit();
  userCubit.userLogin(username: "ali@gmail.com", password: "124");
}
