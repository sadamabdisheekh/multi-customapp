// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String token;

  const CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.token,
  });

  CustomerModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? mobile,
    String? token,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'token': token,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      mobile: map['mobile'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(id: $id, firstName: $firstName, lastName: $lastName, mobile: $mobile, token: $token)';
  }

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      mobile,
      token,
    ];
  }
}
