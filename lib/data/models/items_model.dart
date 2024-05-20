// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ItemsModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String price;
  final String? discount;
  final String availableTimeStarts;
  final String availableTimeEnds;

  const ItemsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.price,
    this.discount,
    required this.availableTimeStarts,
    required this.availableTimeEnds,
  });

  ItemsModel copyWith({
    int? id,
    String? name,
    String? description,
    String? createdAt,
    String? price,
    String? discount,
    String? availableTimeStarts,
    String? availableTimeEnds,
  }) {
    return ItemsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      availableTimeStarts: availableTimeStarts ?? this.availableTimeStarts,
      availableTimeEnds: availableTimeEnds ?? this.availableTimeEnds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt,
      'price': price,
      'discount': discount,
      'available_time_starts': availableTimeStarts,
      'available_time_ends': availableTimeEnds,
    };
  }

  factory ItemsModel.fromMap(Map<String, dynamic> map) {
    return ItemsModel(
      id: (map["id"] ?? 0) as int,
      name: (map["name"] ?? '') as String,
      description: (map["description"] ?? '') as String,
      createdAt: (map["created_at"] ?? '') as String,
      price: (map["price"] ?? '') as String,
      discount: map['discount'] != null ? map["discount"] ?? '' : null,
      availableTimeStarts: (map["available_time_starts"] ?? '') as String,
      availableTimeEnds: (map["available_time_ends"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemsModel.fromJson(String source) =>
      ItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  List<Object?> get props => [
        id,
        name,
        description,
        createdAt,
        price,
        discount,
        availableTimeStarts,
        availableTimeEnds
      ];
}
