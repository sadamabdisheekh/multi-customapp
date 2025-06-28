// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Variation extends Equatable {
  final int id;
  final String sku;
  final String displayName;
  final List<Attributes> attributes;
  const Variation({
    required this.id,
    required this.sku,
    required this.displayName,
    required this.attributes,
  });
 

  Variation copyWith({
    int? id,
    String? sku,
    String? displayName,
    List<Attributes>? attributes,
  }) {
    return Variation(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      displayName: displayName ?? this.displayName,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sku': sku,
      'displayName': displayName,
      'attributes': attributes.map((x) => x.toMap()).toList(),
    };
  }

  factory Variation.fromMap(Map<String, dynamic> map) {
    return Variation(
      id: map['id'] as int,
      sku: map['sku'] as String,
      displayName: map['displayName'] as String,
      attributes: List<Attributes>.from((map['attributes'] as List).map<Attributes>((x) => Attributes.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Variation.fromJson(String source) => Variation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, sku, displayName, attributes];
}

class Attributes extends Equatable {
  final String name;
  final String value;
  const Attributes({
    required this.name,
    required this.value,
  });

  Attributes copyWith({
    String? name,
    String? value,
  }) {
    return Attributes(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory Attributes.fromMap(Map<String, dynamic> map) {
    return Attributes(
      name: map['name'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attributes.fromJson(String source) => Attributes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, value];
}
