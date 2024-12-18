// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String accessToken;
  final User user;

  UserModel({
    required this.accessToken,
    required this.user,
  });

  UserModel copyWith({
    String? accessToken,
    User? user,
  }) =>
      UserModel(
        accessToken: accessToken ?? this.accessToken,
        user: user ?? this.user,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user": user.toJson(),
      };
}

class User {
  final int id;
  final String username;
  final String email;
  final String? image;
  final int rating;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.image,
    required this.rating,
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? image,
    int? rating,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        image: image ?? this.image,
        rating: rating ?? this.rating,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        image: json["image"] ?? '',
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "image": image,
        "rating": rating,
      };
}

final UserModel temp = UserModel(
  accessToken: '',
  user: User(
    id: 0,
    username: '',
    email: '',
    image: '',
    rating: 0,
  ),
);
