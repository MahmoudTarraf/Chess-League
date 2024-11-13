// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String job;
  final int age;

  UserModel({required this.name, required this.job, required this.age});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'job': job,
      'age': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      job: map['job'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
