import 'dart:convert';

import 'package:haldac/model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  // String baseUrl = 'http://api.loradigital.com/public/api';
  String baseUrl = 'http://therapeutic.sakataguna-dev.com/public/api';
  // Future<CategoryGet> getProductsbyCategory(String? categoriesId) async {
  //   var url = Uri.parse('$baseUrl/categories?id=' + (categoriesId).toString());
  //   var headers = {'Content-Type': 'application/json'};

  //   var response = await http.get(url, headers: headers);

  //   print(response.body);
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body)['data'];
  //     List dokter = CategoryGet().from
  //     // CategoryGet category = CategoryGet.fromJson(data['']);

  //     return category;
  //   } else {
  //     throw Exception('gagal ambil data');
  //   }
  // }

  Future<List<DoctorModel>> getProductsbyCategory(
      String? categoriesId, String? token) async {
    var url = Uri.parse('$baseUrl/categories?id=' + (categoriesId).toString());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['doctors'];

      List<DoctorModel> dokter = [];

      for (var item in data) {
        dokter.add(DoctorModel.fromJson(item));
      }

      // print(print);

      return dokter;

      // CategoryGet category = CategoryGet.fromJson(data['']);

    } else {
      throw Exception('gagal ambil data');
    }
  }
}
