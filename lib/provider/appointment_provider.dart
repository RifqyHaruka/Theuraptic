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

  Future<bool> getAppointmentDetail(
      int? appointmentId,
      int? doctorsId,
      String? appointmentStart,
      String token,
      String? appointmentEnd,
      int duration,
      int price) async {
    try {
      await AppointmentServices().appointmentDetail(appointmentId, doctorsId,
          appointmentStart, token, appointmentEnd, duration, price);
      return true;
    } catch (e) {
      print(e);
      print('Salah di Provider Appointment Detail');
      return false;
    }
  }

  int _nilai = 1;

  int get getNilai => _nilai;

  set setNilai(int value) {
    _nilai = value;
    notifyListeners();
  }

  DateTime _waktu = DateTime.now();

  DateTime get waktu => _waktu;
  set waktu(DateTime waktu) {
    _waktu = waktu;
    notifyListeners();
  }

  List<String> _sesi = [''];
  List<String> get sesi => _sesi;
  set sesi(List<String> sesi) {
    _sesi = sesi;
    notifyListeners();
  }

  List<DateTime> _time = [];

  List<DateTime> get time => _time;
  set time(List<DateTime> time) {
    if (_time.isEmpty) {}
    _time = time;
    notifyListeners();
  }
}
