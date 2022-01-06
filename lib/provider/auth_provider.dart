import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/user_model.dart';
import 'package:haldac/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user as UserModel;

  String _roles = 'USER';

  String get roles => _roles;
  set roles(String roles) {
    _roles = roles;
    notifyListeners();
  }

  String? _veriv;

  String get veriv => _veriv as String;
  set veriv(String veriv) {
    _veriv = veriv;
    notifyListeners();
  }

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  DoctorModel? _dokter;

  DoctorModel get dokter => _dokter as DoctorModel;

  set dokter(DoctorModel dokter) {
    _dokter = dokter;
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

  Future<bool> registerDokter(
      String? name,
      String? username,
      String? email,
      String? password,
      String? phoneNumber,
      String? nomorLisensi,
      String? nomorKta,
      String? nomorSertifikat,
      String? exprience) async {
    try {
      DoctorModel dokter = await AuthService().registerDokter(
          name,
          username,
          email,
          password,
          phoneNumber,
          nomorLisensi,
          nomorKta,
          nomorSertifikat,
          exprience) as DoctorModel;
      _dokter = dokter;
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

  Future<bool> editDokter(String? username, String? nomorTelfon, String? email,
      String? password, String? token) async {
    try {
      DoctorModel dokter = await AuthService()
          .editDoctor(username, nomorTelfon, email, password, token);
      _dokter = dokter;
      return true;
    } catch (e) {
      print('Salah di Provider edit dokter');
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

  Future<bool> getPic(String token, File file) async {
    try {
      await AuthService().updateFoto(token, file);

      return true;
    } catch (e) {
      print('Salah di Upload Provider');
      print(e);
      return false;
    }
  }

  Future<bool> getPicTherapis(String token, File file) async {
    try {
      await AuthService().updateFotoTerapis(token, file);

      return true;
    } catch (e) {
      print('Salah di Upload Provider');
      print(e);
      return false;
    }
  }

  Future<bool> loginDokter(String username, String password) async {
    try {
      DoctorModel dokter = await AuthService().loginDokter(username, password);
      _dokter = dokter;
      return true;
    } catch (e) {
      print('Salah login dokter di provider');
      print(e);
      return false;
    }
  }

  Future<bool> getDokter() async {
    try {
      SharedPreferences prefToken = await SharedPreferences.getInstance();
      var getPrefToken = prefToken.get('token');
      DoctorModel dokter =
          await AuthService().getDokter(getPrefToken as String);
      _dokter = dokter;
      return true;
    } catch (e) {
      print(e);
      print('salah di provider get dokter');
      return false;
    }
  }
}
