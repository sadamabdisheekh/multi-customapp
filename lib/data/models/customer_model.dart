// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final int userId;
  final int customerId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String mobile;
  final String email;
  final String token;
  const CustomerModel({
    required this.userId,
    required this.customerId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.token,
  });

  CustomerModel copyWith({
    int? userId,
    int? customerId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? mobile,
    String? email,
    String? token,
  }) {
    return CustomerModel(
      userId: userId ?? this.userId,
      customerId: customerId ?? this.customerId,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'customerId': customerId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'mobile': mobile,
      'email': email,
      'token': token,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      userId: map['userId'] as int,
      customerId: map['customerId'] as int,
      firstName: map['firstName'] as String,
      middleName: map['middleName'] as String,
      lastName: map['lastName'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) => CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      userId,
      customerId,
      firstName,
      middleName,
      lastName,
      mobile,
      email,
      token,
    ];
  }
}
