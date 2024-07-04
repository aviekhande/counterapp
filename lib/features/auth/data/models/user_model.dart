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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['uid'] = this.uid;
    return data;
  }
}
