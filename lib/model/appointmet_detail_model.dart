class AppointmentDetailModel {
  int? id;
  String? date;
  String? sesiAkhir;
  int? price;
  int? duration;
  String? status;

  AppointmentDetailModel(this.id, this.date, this.sesiAkhir, this.price,
      this.duration, this.status);

  AppointmentDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['appointment_start'];
    sesiAkhir = json['appointment_end'];
    price = json['price'];
    duration = json['duration'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointment_start': date,
      'appointment_end': sesiAkhir,
      'price': price,
      'duration': duration,
      'status': status,
    };
  }
}
