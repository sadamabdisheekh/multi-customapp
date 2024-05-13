// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final bool status;
  final String createdAt;
  final dynamic updatedAt;
  final int priority;
  final List<SubCategory> subCategory;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.priority,
    required this.subCategory,
  });


  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
    bool? status,
    String? createdAt,
    String? updatedAt,
    int? priority,
    List<SubCategory>? subCategory,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
      subCategory: subCategory ?? this.subCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'priority': priority,
      'subCategory': subCategory.map((x) {return x.toMap();}).toList(growable: false),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: (map["id"] ?? 0) as int,
      name: (map["name"] ?? '') as String,
      image: (map["image"] ?? '') as String,
      status: (map["status"] ?? false) as bool,
      createdAt: (map["createdAt"] ?? '') as String,
      updatedAt: map["updatedAt"] ?? null as dynamic,
      priority: (map["priority"] ?? 0) as int,
      subCategory: List<SubCategory>.from(((map['subCategory'] ?? const <SubCategory>[]) as List).map<SubCategory>((x) {return SubCategory.fromMap((x?? Map<String,dynamic>.from({})) as Map<String,dynamic>);}),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      image,
      status,
      createdAt,
      updatedAt,
      priority,
      subCategory,
    ];
  }
}

class SubCategory {
  final int id;
  final String name;

  const SubCategory({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: (map["id"] ?? 0) as int,
      name: (map["name"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubCategory(id: $id, name: $name)';
}
