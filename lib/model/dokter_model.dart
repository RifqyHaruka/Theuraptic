import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/hospital_model.dart';

class Dokter {
  int? id;

  String? name;
  String? experince;
  String? lisenceNumber;
  String? language;
  String? phone;
  int? price;
  Category? category;
  Hospital? hospital;

  Dokter({
    this.id,
    this.name,
    this.experince,
    this.lisenceNumber,
    this.language,
    this.phone,
    this.price,
    this.category,
    this.hospital,
  });

  Dokter.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];
    experince = json['experience'];
    lisenceNumber = json['lisence_number'];
    language = json['language'];
    phone = json['phone_number'];
    price = json['price'];
    category = Category.fromJson(json['category']);
    hospital = Hospital.fromJson(json['hospital']);
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
      'category': category!.toJson(),
      'hospital': hospital!.toJson(),
    };
  }
}
