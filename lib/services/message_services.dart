import 'dart:convert';

import 'package:haldac/model/message_model.dart';
import 'package:http/http.dart' as http;

class MessageService {
  var url = 'http://therapeutic.pejuangpi.com/backend/api/conversation/3';

  Future<List<MessageModel>> getMessage(String token) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['messages'];

      List<MessageModel> model = [];

      for (var item in data) {
        model.add(MessageModel.fromJson(item));
      }

      return model;
    } else {
      throw Exception('gagal ambil data');
    }
  }
}
