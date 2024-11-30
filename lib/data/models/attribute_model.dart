// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Attribute extends Equatable {
  final int id;
  final String name;
  final List<AttributeValue> values;

  const Attribute({
    required this.id,
    required this.name,
    required this.values,
  });

  Attribute copyWith({
    int? id,
    String? name,
    List<AttributeValue>? values,
  }) {
    return Attribute(
      id: id ?? this.id,
      name: name ?? this.name,
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'values': values.map((x) => x.toMap()).toList(),
    };
  }

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      id: map['id'] as int,
      name: map['name'] as String,
      values: List<AttributeValue>.from((map['values'] as List<dynamic>).map<AttributeValue>((x) => AttributeValue.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attribute.fromJson(String source) => Attribute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Attribute(id: $id, name: $name, values: $values)';


  @override
  List<Object> get props => [id, name, values];
}

class AttributeValue extends Equatable {
  final int id;
  final String name;

  const AttributeValue({
    required this.id,
    required this.name,
  });

  AttributeValue copyWith({
    int? id,
    String? name,
  }) {
    return AttributeValue(
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

  factory AttributeValue.fromMap(Map<String, dynamic> map) {
    return AttributeValue(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeValue.fromJson(String source) => AttributeValue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AttributeValue(id: $id, name: $name)';


  @override
  List<Object> get props => [id, name];
}
