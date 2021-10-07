class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? password;
  String? photoUrl;
  String? phoneNumber;
  String? token;
  int? currentId;
  String? roles;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.password,
      this.phoneNumber,
      this.token,
      this.photoUrl,
      this.currentId,
      this.roles});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    phoneNumber = json['phone_number'];
    token = json['access_token'];
    photoUrl = json['photo'];
    currentId = json['current_team_id'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'access_token': token,
      'photo': photoUrl,
      'current_team_id': currentId,
      'roles': roles
    };
  }
}

class UserEditModel extends UserModel {}
