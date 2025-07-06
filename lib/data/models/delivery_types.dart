// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeliveryTypesModel extends Equatable {
  final int id;
  final String name;
  const DeliveryTypesModel({
    required this.id,
    required this.name,
  });
  

  DeliveryTypesModel copyWith({
    int? id,
    String? name,
  }) {
    return DeliveryTypesModel(
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

  factory DeliveryTypesModel.fromMap(Map<String, dynamic> map) {
    return DeliveryTypesModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryTypesModel.fromJson(String source) => DeliveryTypesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
