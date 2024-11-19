// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final bool status;
  final String createdAt;
  final int priority;
  final List<CategoryModel> children;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.priority,
    required this.children,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
    bool? status,
    String? createdAt,
    int? priority,
    List<CategoryModel>? children,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'status': status,
      'createdAt': createdAt,
      'priority': priority,
      'children': children.map((x) {
        return x.toMap();
      }).toList(growable: false),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: (map["id"] ?? 0) as int,
      name: (map["name"] ?? '') as String,
      image: (map["image"] ?? '') as String,
      status: (map["status"] ?? false) as bool,
      createdAt: (map["createdAt"] ?? '') as String,
      priority: (map["priority"] ?? 0) as int,
      children: List<CategoryModel>.from(
        ((map['children'] ?? const <CategoryModel>[]) as List)
            .map<CategoryModel>((x) {
          return CategoryModel.fromMap(
              (x ?? Map<String, dynamic>.from({})) as Map<String, dynamic>);
        }),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
      priority,
      children,
    ];
  }
}

