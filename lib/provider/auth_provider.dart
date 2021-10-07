import 'package:flutter/cupertino.dart';
import 'package:haldac/model/user_model.dart';
import 'package:haldac/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user as UserModel;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(String? name, String? username, String? email,
      String? password, String? phoneNumber) async {
    try {
      UserModel user = await AuthService().register(
          name: name,
          username: username,
          email: email,
          password: password,
          phoneNumber: phoneNumber);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login(String? username, String? password) async {
    try {
      UserModel user =
          await AuthService().login(username: username, password: password);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      print('salah disini');
      return false;
    }
  }

  Future<bool> logout(String token) async {
    try {
      if (await AuthService().logout(token)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit(
      {String? name,
      String? username,
      String? email,
      String? phoneNumber,
      String? token}) async {
    try {
      UserModel user = await AuthService().edit(
          name: name,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
          token: token);
      token = token;
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getData() async {
    SharedPreferences prefToken = await SharedPreferences.getInstance();
    var getPrefToken = prefToken.get('token');
    try {
      UserModel user = await AuthService().getData(getPrefToken as String);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
