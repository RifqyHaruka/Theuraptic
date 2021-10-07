import 'dart:convert';

import 'package:haldac/model/appointment_model.dart';
import 'package:http/http.dart' as http;

class AppointmentServices {
  // String baseUrl = 'http://api.loradigital.com/public/api';
  String baseUrl = 'http://therapeutic.sakataguna-dev.com/public/api';

  Future<AppointmentModel> appointmentServices(int? userId, int? doctorsId,
      int? price, String? name, String? email, String token) async {
    var url = Uri.parse('$baseUrl/transaction');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({
      'users_id': userId,
      'doctors_id': doctorsId,
      'price': price,
      'name': name,
      'email': email
    });
    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      AppointmentModel appointment = AppointmentModel.fromJson(data);
      return appointment;
    } else {
      throw Exception('Error di Service');
    }
  }
}
