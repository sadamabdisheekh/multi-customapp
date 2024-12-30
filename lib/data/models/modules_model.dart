// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModulesModel {
  final int id;
  final String moduleName;
  final String image;
  final bool status;
  final String? icon;
  final String? description;
  final String createdAt;
  final String? updatedAt;

  ModulesModel({
    required this.id,
    required this.moduleName,
    required this.image,
    required this.status,
    this.icon,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'ModulesModel(id: $id, moduleName: $moduleName, image: $image, status: $status, icon: $icon, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  ModulesModel copyWith({
    int? id,
    String? moduleName,
    String? image,
    bool? status,
    String? icon,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return ModulesModel(
      id: id ?? this.id,
      moduleName: moduleName ?? this.moduleName,
      image: image ?? this.image,
      status: status ?? this.status,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'module_name': moduleName,
      'image': image,
      'status': status,
      'icon': icon,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ModulesModel.fromMap(Map<String, dynamic> map) {
    return ModulesModel(
      id: map['id'] as int,
      moduleName: map['module_name'] as String,
      image: map['image'] as String,
      status: map['status'] as bool,
      icon: map['icon'] != null ? map['icon'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModulesModel.fromJson(String source) =>
      ModulesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
