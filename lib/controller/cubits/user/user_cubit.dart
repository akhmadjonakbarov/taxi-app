// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/models/models.dart';

import '../../api/constants.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  String? _token;

  Map<String, String> headers = {"content-type": "application/json"};
  late User _user;

  bool get isAuth {
    return _token != null;
  }

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
        final resData = await jsonDecode(response.body);
        _token = resData["user_info"]["access"];
        http.Response resUser = await http.get(
          getUserUrl,
          headers: {"Authorization": "Bearer $_token"},
        );

        final userData = jsonDecode(resUser.body);
        _user = User(
          id: userData["id"],
          firstName: userData["first_name"],
          lastName: userData["last_name"],
          phoneNumber: userData["phone_number"],
          token: _token!,
          services: userData["services"],
        );
        emit(UserLogin(user: _user));
        final prefs = await SharedPreferences.getInstance();

        prefs.setString('token', _token!);
      } catch (e) {
        emit(
          UserError(errorMsg: e.toString()),
        );
      }
    }
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = "";
    final getUserUrl =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndPoint);
    if (prefs.containsKey("token")) {
      userToken = prefs.getString("token")!;
      http.Response resUser = await http.get(
        getUserUrl,
        headers: {"Authorization": "Bearer $userToken"},
      );
      final userData = jsonDecode(resUser.body);
      _user = User(
        id: userData["id"],
        firstName: userData["first_name"],
        lastName: userData["last_name"],
        phoneNumber: userData["phone_number"],
        token: userToken,
        services: userData["services"],
      );
      emit(UserLogin(user: _user));
    }
  }

  Future<void> userLogOut() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      prefs.setString("token", "");
    }
    try {
      _user = User(
        id: 0,
        firstName: "",
        lastName: "",
        phoneNumber: "",
        token: "",
        services: [],
      );
      _token = "";

      emit(UserLogout(user: _user));
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
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
  userCubit.userLogin(username: "931634600", password: "322");
}
