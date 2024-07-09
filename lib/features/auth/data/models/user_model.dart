class User {
  String? email;
  String? name;
  String? uid;

  User({this.email, this.name, this.uid});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['uid'] = uid;
    return data;
  }
}
