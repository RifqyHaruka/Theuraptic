import 'package:flutter/cupertino.dart';
import 'package:haldac/model/appointment_model.dart';
import 'package:haldac/services/appointment_services.dart';

class AppointmentProvider with ChangeNotifier {
  AppointmentModel? _appointment;

  AppointmentModel get appointment => _appointment as AppointmentModel;

  set appointment(AppointmentModel appointment) {
    _appointment = appointment;
    notifyListeners();
  }

  Future<bool> getAppointment(int? userId, int? doctorsId, int? price,
      String? name, String? email, String token) async {
    try {
      AppointmentModel appointment = await AppointmentServices()
          .appointmentServices(userId, doctorsId, price, name, email, token);
      _appointment = appointment;
      return true;
    } catch (e) {
      print(e);
      print('Salah di provider');
      return false;
    }
  }

  int _nilai = 1;

  int get getNilai => _nilai;

  set setNilai(int value) {
    _nilai = value;
    notifyListeners();
  }

  String _waktu = '';

  String get waktu => _waktu;
  set waktu(String waktu) {
    _waktu = waktu;
    notifyListeners();
  }
}
