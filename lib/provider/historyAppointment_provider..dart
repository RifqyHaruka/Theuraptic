import 'package:flutter/cupertino.dart';
import 'package:haldac/model/appointmet_detail_model.dart';
import 'package:haldac/model/historyAppointment_model.dart';
import 'package:haldac/services/historyAppointment_services.dart';

class HistoryAppointmentProvider with ChangeNotifier {
  List<HistoryAppointmentModel> _history = [];
  List<AppointmentDetailModel> _historyDetail = [];

  List<HistoryAppointmentModel> get history => _history;
  set history(List<HistoryAppointmentModel> history) {
    _history = history;
    notifyListeners();
  }

  List<AppointmentDetailModel> get historydetail => _historyDetail;
  set historydetail(List<AppointmentDetailModel> historyDetail) {
    _historyDetail = historyDetail;
    notifyListeners();
  }

  Future<bool> getHistory(String token, int id) async {
    try {
      List<HistoryAppointmentModel> history =
          await HistoryService().getHistory(token, id);
      _history = history;
      return true;
    } catch (e) {
      print('Salah di provider');
      print(e);
      return false;
    }
  }

  Future<bool> getHistorybyDoctorId(String token, int id) async {
    try {
      List<HistoryAppointmentModel> history =
          await HistoryService().getHistoryByDoctorId(token, id);
      _history = history;
      return true;
    } catch (e) {
      print('salah di provider get history by doctor');
      print(e);
      return false;
    }
  }

  Future<bool> getHistoryDetail(String token, int id) async {
    try {
      List<AppointmentDetailModel> historyDetail =
          await HistoryService().getHistoryDetail(token, id);
      _historyDetail = historyDetail;
      print('Histori dari provider' + _historyDetail.toString());
      return true;
    } catch (e) {
      print('Salah appointment detail di provider');
      print(e);
      return false;
    }
  }

  Future<bool> setStatus(String token, int id) async {
    try {
      if (await HistoryService().updateStatuseAppointmentDetail(token, id)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      print('Salah di Provider');
      return false;
    }
  }
}
