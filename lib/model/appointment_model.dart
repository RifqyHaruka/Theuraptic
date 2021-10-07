class AppointmentModel {
  String? url;
  String? appToken;

  AppointmentModel(this.url, this.appToken);

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    appToken = json['token'];
    url = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    return {'token': appToken, 'payment_url': url};
  }
}
