class AppointmentModel {
  String? url;
  String? appToken;
  int? id;

  AppointmentModel(this.url, this.appToken, this.id);

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    appToken = json['token'];
    url = json['payment_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'token': appToken, 'payment_url': url, 'id': id};
  }
}
