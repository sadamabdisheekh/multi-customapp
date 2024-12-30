// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentMethodsModel extends Equatable {
  final int id;
  final String name;

  const PaymentMethodsModel({
    required this.id,
    required this.name,
  });


  PaymentMethodsModel copyWith({
    int? id,
    String? name,
  }) {
    return PaymentMethodsModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory PaymentMethodsModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodsModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodsModel.fromJson(String source) => PaymentMethodsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
