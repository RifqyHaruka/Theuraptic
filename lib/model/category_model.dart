import 'package:flutter/services.dart';
import 'package:haldac/model/dokter_model.dart';

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class DoctorModel {
  int? id;
  int? usersId;
  String? token;
  String? name;
  String? experince;
  String? lisenceNumber;
  String? ktaNumber;
  String? certificateNumber;
  String? photo;
  String? phone;
  int? price;
  String? isVerified;
  String? slug;

  DoctorModel(
      {this.id,
      this.usersId,
      this.name,
      this.experince,
      this.lisenceNumber,
      this.ktaNumber,
      this.certificateNumber,
      this.photo,
      this.phone,
      this.price,
      this.isVerified,
      this.slug});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    token = json['access_token'];
    name = json['name'];
    experince = json['experience'];
    lisenceNumber = json['lisence_number'];
    ktaNumber = json['kta_number'];
    certificateNumber = json['certificate_number'];
    photo = json['photo'];
    phone = json['phone_number'];
    price = json['price'];
    isVerified = json['is_verified'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'access_token': token,
      'name': name,
      'experience': experince,
      'lisence_number': lisenceNumber,
      'kta_number ': ktaNumber,
      'certificate_number': certificateNumber,
      'photo': photo,
      'phone_number': phone,
      'price': price,
      'is_verified': isVerified,
      'slug': slug
    };
  }
}
