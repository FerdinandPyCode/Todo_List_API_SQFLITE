// To parse this JSON data, do
//
//     final authenticatedUser = authenticatedUserFromJson(jsonString);

import 'dart:convert';

AuthenticatedUser authenticatedUserFromJson(String str) =>
    AuthenticatedUser.fromJson(json.decode(str));

class AuthenticatedUser {
  AuthenticatedUser({
    this.accessToken,
    this.authentication,
    this.user,
  });

  String? accessToken;
  Authentication? authentication;
  User? user;

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      AuthenticatedUser(
        accessToken: json["accessToken"],
        authentication: json["authentication"] == null
            ? null
            : Authentication.fromJson(json["authentication"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class Authentication {
  Authentication({
    this.strategy,
    this.payload,
  });

  String? strategy;
  Payload? payload;

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        strategy: json["strategy"],
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
      );
}

class Payload {
  Payload({
    this.iat,
    this.exp,
    this.aud,
    this.sub,
    this.jti,
  });

  int? iat;
  int? exp;
  String? aud;
  String? sub;
  String? jti;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        iat: json["iat"],
        exp: json["exp"],
        aud: json["aud"],
        sub: json["sub"],
        jti: json["jti"],
      );
}

class User {
  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.username,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;
  String? username;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        email: json["email"],
        username: json["username"],
      );

  // Map<String, dynamic> toMap(User user) {
  //   Map<String, dynamic> map = {
  //     "id":id,

  //   };

  //   return map;
  // }
}
