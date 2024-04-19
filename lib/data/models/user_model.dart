import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int userId;
  final String firstName;
  final String lastName;
  final String phone;
  final String accessToken;

  const UserModel(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.accessToken});

  @override
  String toString() {
    return 'UserModel(userId: $userId, firstName: $firstName, lastName: $lastName, phone: $phone, accessToken: $accessToken)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'accessToken': accessToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: (map["userId"] ?? 0) as int,
      firstName: (map["firstName"] ?? '') as String,
      lastName: (map["lastName"] ?? '') as String,
      phone: (map["phone"] ?? '') as String,
      accessToken: (map["accessToken"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [id, firstName, lastName, phone, accessToken];
}
