class UserLoginModel {
  String? username;
  String? password;
  UserLoginModel({this.username, this.password});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};

    data['username'] = username.toString();
    data['password'] = password.toString();
    return data;
  }
}
