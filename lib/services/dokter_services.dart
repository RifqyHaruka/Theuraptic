import 'dart:convert';

import 'package:haldac/model/dokter_model.dart';
import 'package:http/http.dart' as http;

class DokterService {
  String baseUrl = 'http://api.loradigital.com/public/api';
  Future<List<Dokter>> getDokter(String? token) async {
    var url = Uri.parse('$baseUrl/doctors');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<Dokter> dokter = [];

      for (var item in data) {
        dokter.add(Dokter.fromJson(item));
      }

      return dokter;
    } else {
      throw Exception('Data Gagal Diambil');
    }
  }
}
