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
  String? name;
  String? experince;
  String? lisenceNumber;
  String? language;
  String? phone;
  int? price;
  String? slug;

  DoctorModel(
      {this.id,
      this.name,
      this.experince,
      this.lisenceNumber,
      this.language,
      this.phone,
      this.price,
      this.slug});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    experince = json['experience'];
    lisenceNumber = json['lisence_number'];
    language = json['language'];
    phone = json['phone_number'];
    price = json['price'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'experience': experince,
      'lisence_number': lisenceNumber,
      'language': language,
      'phone_number': phone,
      'price': price,
      'slug': slug
    };
  }
}
