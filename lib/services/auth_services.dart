import 'dart:convert';
import 'dart:io';

import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/user_model.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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

  Future<DoctorModel?> registerDokter(
      String? name,
      String? username,
      String? email,
      String? password,
      String? phoneNumber,
      String? nomorLisensi,
      String? nomorKta,
      String? nomorSertifikat,
      String? exprience) async {
    var url = Uri.parse('$baseUrl/registerDoctor');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'lisence_number': nomorLisensi,
      'kta_number': nomorKta,
      'certificate_number': nomorSertifikat,
      'experience': exprience
    });
    var response = await http.post(url, headers: headers, body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      DoctorModel dokter = DoctorModel.fromJson(data['user']);
      dokter.token = 'Bearer ' + data['access_token'];
      return dokter;
    } else if (response.statusCode == 500) {
      var dataUname =
          jsonDecode(response.body)['data']['validation_errors'].toString();

      if (dataUname.contains('username has already')) {
        SharedPreferences veriv = await SharedPreferences.getInstance();
        veriv.setString(
            'veriv', 'Username sudah terdaftar, silahkan ganti username');
      } else if (dataUname.contains('email has already')) {
        SharedPreferences veriv = await SharedPreferences.getInstance();
        veriv.setString('veriv', 'Email suda terdaftar, silahkan ganti email');
      } else if (dataUname.contains('phone number has already')) {
        SharedPreferences veriv = await SharedPreferences.getInstance();
        veriv.setString('veriv',
            'Nomor Telfon sudah terdaftar, silahkan ganti nomor telfon');
      } else if (dataUname.contains('lisence number has already')) {
        SharedPreferences veriv = await SharedPreferences.getInstance();
        veriv.setString('veriv',
            'Nomor Lisensi sudah terdaftar, silahkan ganti nomor lisensi');
      } else if (dataUname.contains('kta number has already')) {
        SharedPreferences veriv = await SharedPreferences.getInstance();
        veriv.setString(
            'veriv', 'Nomor KTA sudah terdaftar, silahkan ganti nomor KTA');
      } else if (dataUname.contains('certificate number has already')) {
        SharedPreferences veriv = await SharedPreferences.getInstance();
        veriv.setString('veriv',
            'Nomor Sertifikat sudah terdaftar, silahkan ganti nomor Sertifikat');
      } else {
        SharedPreferences veriv = await SharedPreferences.getInstance();
        veriv.setString('veriv',
            'Server sedang maintenance mohon kunjungi beberapa saat lagi');
      }

      print(dataUname);
      // print(dataEmail);

      // if (dataUname.contains('already')) {
      //   veriv.setString('veriv', 'Salah di UserName');
      // } else if (dataPhone.contains('already')) {
      //   veriv.setString('veriv', 'Salah di PhoneNumber');
      // } else if (dataEmail.contains('already')) {
      //   veriv.setString('veriv', 'Salah di Email');
      // } else if (dataLicense.contains('already')) {
      //   veriv.setString('veriv', 'Salah di License');
      // } else if (dataKta.contains('already')) {
      //   veriv.setString('veriv', 'Salah di KTA');
      // } else if (dataSertifikat.contains('already')) {
      //   veriv.setString('veriv', 'Salah di Sertifikat');
      // }
    } else {
      throw Exception('Salah Register Dokter di service');
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

  Future<DoctorModel> loginDokter(String username, String password) async {
    var url = Uri.parse('$baseUrl/loginan');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'username': username, 'password': password});
    var response = await http.post(url, headers: headers, body: body);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      DoctorModel dokter = DoctorModel.fromJson(data['doctor']);
      dokter.token = 'Bearer ' + data['access_token'];
      print(dokter.token);

      return dokter;
    } else {
      throw Exception('Gagal Login Dokter Salah di Service');
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

  Future<DoctorModel> editDoctor(String? username, String? nomorTelfon,
      String? email, String? password, String? token) async {
    var url = Uri.parse('$baseUrl/updateDoctor');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var body = jsonEncode({
      'name': username,
      'username': username,
      'email': email,
      'phone_number': nomorTelfon,
    });

    var response = await http.post(url, body: body, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['doctors'];
      DoctorModel doctor = DoctorModel.fromJson(data[0]);
      doctor.token = token;

      return doctor;
    } else {
      throw Exception('Salah di Service');
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

  Future<void> updateFoto(String token, File file) async {
    var url = Uri.parse('$baseUrl/updatephoto');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.files.add(await http.MultipartFile.fromPath('photo', file.path));

    var res = await request.send();
    print(res.reasonPhrase);
  }

  Future<void> updateFotoTerapis(String token, File file) async {
    var url = Uri.parse('$baseUrl/updatephotodoctor');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.files.add(await http.MultipartFile.fromPath('photo', file.path));

    var res = await request.send();
    print(res.reasonPhrase);
  }

  Future<DoctorModel> getDokter(String token) async {
    var url = '$baseUrl/getdoctor';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DoctorModel doctor = DoctorModel.fromJson(data['data'][0]);
      doctor.token = token;
      print(doctor.token);
      return doctor;
    } else {
      throw Exception('Print Salah di Service');
    }
  }
}
