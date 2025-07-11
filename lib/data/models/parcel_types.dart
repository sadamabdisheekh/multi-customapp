// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ParcelTypesModel extends Equatable {
  final int id;
  final String name;
  const ParcelTypesModel({
    required this.id,
    required this.name,
  });
  

  ParcelTypesModel copyWith({
    int? id,
    String? name,
  }) {
    return ParcelTypesModel(
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

  factory ParcelTypesModel.fromMap(Map<String, dynamic> map) {
    return ParcelTypesModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelTypesModel.fromJson(String source) => ParcelTypesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
