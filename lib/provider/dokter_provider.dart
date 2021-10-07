import 'package:flutter/cupertino.dart';

import 'package:haldac/model/dokter_model.dart';

import 'package:haldac/services/dokter_services.dart';

class DokterProvider with ChangeNotifier {
  List<Dokter> _dokter = [];

  List<Dokter> get dokter => _dokter;

  set dokter(List<Dokter> dokter) {
    _dokter = dokter;
    notifyListeners();
  }

  Future<void> getDokters(String? token) async {
    try {
      List<Dokter> dokter = await DokterService().getDokter(token);
      _dokter = dokter;
    } catch (e) {
      print(e);
    }
  }
}
