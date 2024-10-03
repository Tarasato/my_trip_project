class Profile {
  String? message;
  String? userId;
  String? username;
  String? email;
  String? phone;
  String? password;
  String? fullname;
  String? userpicture;

  Profile(
      {this.message,
      this.userId,
      this.username,
      this.email,
      this.phone,
      this.password,
      this.fullname,
      this.userpicture});

  Profile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    fullname = json['fullname'];
    userpicture = json['userpicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['fullname'] = this.fullname;
    data['userpicture'] = this.userpicture;
    return data;
  }
}
