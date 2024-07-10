class User {
  String? name;
  String? email;
  String? password;
  bool? disabled = false;

  User({this.name, this.email, this.password, this.disabled});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    disabled = json['disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['disabled'] = disabled;
    return data;
  }
}
