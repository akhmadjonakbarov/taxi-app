import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/models.dart';

import '../../api/constants.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  String? _token;
  DateTime? _expiryDate;
  Timer? _autoLogOutTimer;
  late User _user;

  Map<String, String> headers = {"content-type": "application/json"};

  bool get isAuth {
    print("Token:$token");
    return true;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> userRegister({
    required String name,
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndPoint);
    if (name.isNotEmpty && phoneNumber.isNotEmpty && password.isNotEmpty) {
      String data = jsonEncode({
        "first_name": name,
        "phone_number": phoneNumber,
        "password": password
      });
      try {
        http.Response response =
            await http.post(url, body: data, headers: headers);
        final userData = jsonDecode(response.body);
        _token = userData["token"]["token"];

        _expiryDate = DateTime.parse(userData["token"]['expiry']);

        _user = User(
          id: userData["user"]["id"],
          firstName: userData["user"]["first_name"],
          lastName: "",
          phoneNumber: userData["user"]["phone_number"],
          token: _token!,
          services: userData["user"]["services"],
        );
        emit(UserLogin(user: _user));
      } catch (e) {
        emit(
          UserError(
            errorMsg: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> userLogin(
      {required String username, required String password}) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndPoint);
    if (username.isNotEmpty && password.isNotEmpty) {
      String data = jsonEncode({"username": username, "password": password});
      try {
        emit(UserLoading());
        http.Response response =
            await http.post(url, body: data, headers: headers);
        final userData = await jsonDecode(response.body);
        _token = userData["token"];

        _expiryDate = DateTime.parse(userData['expiry']);

        _user = User(
          id: userData["user"]["id"],
          firstName: userData["user"]["first_name"],
          lastName: userData["user"]["last_name"],
          phoneNumber: userData["user"]["phone_number"],
          token: _token!,
          services: userData["user"]["services"],
        );
        emit(UserLogin(user: _user));
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> userMainData = {
          "token": _token,
          "expiryDate": _expiryDate!.toIso8601String(),
        };

        prefs.setString("userMainData", jsonEncode(userMainData));
        autoLogOut();
      } catch (e) {
        emit(
          UserError(errorMsg: e.toString()),
        );
      }
    }
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userMainData")) {}
    Map<String, dynamic> userMainData =
        jsonDecode(prefs.getString("userMainData")!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userMainData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {}
    _token = userMainData['token'];
    _expiryDate = expiryDate;
    print("User: $_user");
    emit(UserLogin(user: _user));
  }

  userLogOut() {
    try {
      _token = null;
      _expiryDate = null;
      if (_autoLogOutTimer != null) {
        _autoLogOutTimer!.cancel();
        _autoLogOutTimer = null;
      }
      emit(UserLogout());
    } catch (e) {
      emit(
        UserError(
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void autoLogOut() {
    if (_autoLogOutTimer != null) {
      _autoLogOutTimer!.cancel();
    }
    final finishTime = _expiryDate!.difference(DateTime.now()).inSeconds;
    _autoLogOutTimer = Timer(Duration(seconds: finishTime), userLogOut);
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
}
