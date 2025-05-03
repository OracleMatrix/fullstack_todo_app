import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String? message;
  User? user;
  String? token;

  UserInfoModel({this.message, this.user, this.token});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  int? id;
  String? username;
  String? email;

  User({this.id, this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json["id"], username: json["username"], email: json["email"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
  };
}
