import 'package:haldac/model/appointmet_detail_model.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/user_model.dart';

class HistoryAppointmentModel {
  int? id;
  int? usersId;
  int? doctorsId;
  int? price;
  String? code;
  DateTime? createdAt;
  UserModel? user;
  DoctorModel? dokter;

  HistoryAppointmentModel(this.id, this.usersId, this.doctorsId, this.price,
      this.code, this.createdAt, this.user, this.dokter);

  HistoryAppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    doctorsId = json['doctors_id'];
    price = json['price'];
    code = json['code'];
    createdAt = DateTime.parse(json['created_at']);
    user = UserModel.fromJson(json['user']);
    dokter = DoctorModel.fromJson(json['doctors']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'doctors_id': doctorsId,
      'price': price,
      'code': code,
      'created_at': createdAt.toString(),
      'user': user!.toJson(),
      'doctors': dokter!.toJson()
    };
  }
}
