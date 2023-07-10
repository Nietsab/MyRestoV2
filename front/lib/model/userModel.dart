import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModeToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.login,
    required this.password,
    required this.mail,
    required this.address,
    required this.firstName,
    required this.lastName,
  });

  String login;
  String password;
  String mail;
  String address;
  String firstName;
  String lastName;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    login: json["login"],
    password: json["password"],
    mail: json["mail"],
    address: json["address"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "password": password,
    "mail": mail,
    "address": address,
    "firstName": firstName,
    "lastName": lastName,
  };
}