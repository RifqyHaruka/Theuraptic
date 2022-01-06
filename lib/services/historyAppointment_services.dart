import 'dart:convert';

import 'package:haldac/model/appointmet_detail_model.dart';
import 'package:haldac/model/historyAppointment_model.dart';
import 'package:http/http.dart' as http;

class HistoryService {
  String baseUrl = 'http://therapeutic.sakataguna-dev.com/public/api';

  Future<List<HistoryAppointmentModel>> getHistory(
      String? token, int? id) async {
    var url = Uri.parse('$baseUrl/transaction/get?users_id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var response = await http.get(url, headers: headers);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];

      List<HistoryAppointmentModel> history = [];

      for (var item in data) {
        history.add(HistoryAppointmentModel.fromJson(item));
      }

      return history;
    } else {
      throw Exception('Salah di Service');
    }
  }

  Future<List<AppointmentDetailModel>> getHistoryDetail(
      String? token, int id) async {
    var url = Uri.parse('$baseUrl/transaction/get?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var response = await http.get(url, headers: headers);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['details'];
      print(data);

      List<AppointmentDetailModel> historyDetail = [];

      for (var item in data) {
        historyDetail.add(AppointmentDetailModel.fromJson(item));
      }

      return historyDetail;
    } else {
      throw Exception('Salah di Service');
    }
  }

  Future<List<HistoryAppointmentModel>> getHistoryByDoctorId(
      String? token, int id) async {
    var url = Uri.parse('$baseUrl/transaction/get?doctors_id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];
      List<HistoryAppointmentModel> historyTherapis = [];

      for (var item in data) {
        historyTherapis.add(HistoryAppointmentModel.fromJson(item));
      }
      return historyTherapis;
    } else {
      throw Exception('Salah di Service');
    }
  }

  Future<bool> updateStatuseAppointmentDetail(String token, int id) async {
    var url = Uri.parse('$baseUrl/updateStatus/$id');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.post(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Salah di Service');
    }
  }
}
