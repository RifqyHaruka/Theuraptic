import 'dart:convert';

import 'package:haldac/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // String baseUrl = 'http://api.loradigital.com/public/api';
  String baseUrl = 'http://therapeutic.sakataguna-dev.com/public/api';

  Future<UserModel> register(
      {String? name,
      String? username,
      String? email,
      String? password,
      String? phoneNumber}) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // FlutterSecureStorage storage = FlutterSecureStorage();
    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-Type': 'application/json'};
    SharedPreferences pref = await SharedPreferences.getInstance();
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'phone_number': phoneNumber
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      // user.roles = "ADMIN";
      // user.currentId = 1;
      await pref.setString('token', user.token as String);

      // await storage.write(key: 'token', value: user.token);
      // await pref.setString('token', user.token as String);
      // await pref.setString('user', user.username as String);

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({String? username, String? password}) async {
    var url =
        Uri.parse('http://therapeutic.sakataguna-dev.com/public/api/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'username': username, 'password': password});
    SharedPreferences pref = await SharedPreferences.getInstance();

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      Map<String, dynamic> coba = jsonDecode(response.body)['data']['user'];
      UserModel user = UserModel.fromJson(data['user']);
      user.username = data['user']['username'];
      user.token = 'Bearer ' + data['access_token'];
      user.currentId = 1;

      await pref.setString('token', user.token as String);
      await pref.setString('user', user.username as String);
      print(user.token);
      print(user.username);
      print(coba);

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<bool> logout(String token) async {
    var url = Uri.parse('$baseUrl/logout');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.post(url, headers: headers);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('gagal logout');
    }
  }

  Future<UserModel> edit(
      {String? name,
      String? username,
      String? email,
      String? phoneNumber,
      String? token}) async {
    var url = Uri.parse('$baseUrl/user');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // UserModel user = UserModel.fromJson(jsonDecode(response.body)['data']);
      // user.token = 'Bearer ' + data['access_token'];

      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data['data']);
      // user.token = 'Bearer ' + data['access_token'];
      print(user);

      user.token = token;

      return user;
    } else {
      throw Exception('Gagal Edit Data');
    }
  }

  Future<UserModel> getData(String token) async {
    var url = Uri.parse('$baseUrl/user');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.get(url, headers: headers);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data['data']);
      // user.token = 'Bearer ' + data['access_token'];
      print(user);

      user.token = token;

      return user;
    } else {
      throw Exception('Gagal Ambil Data');
    }
  }
}
