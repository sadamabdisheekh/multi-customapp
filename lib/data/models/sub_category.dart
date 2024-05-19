// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';


class SubCategoryModel extends Equatable{
  final int id;
  final String subCategoryName;
  final String image;
  final bool status;

  const SubCategoryModel({
    required this.id,
    required this.subCategoryName,
    required this.image,
    required this.status,
  });


  SubCategoryModel copyWith({
    int? id,
    String? subCategoryName,
    String? image,
    bool? status,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subCategoryName': subCategoryName,
      'image': image,
      'status': status,
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: (map["id"] ?? 0) as int,
      subCategoryName: (map["subCategoryName"] ?? '') as String,
      image: (map["image"] ?? '') as String,
      status: (map["status"] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryModel.fromJson(String source) => SubCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubCategory(id: $id, subCategoryName: $subCategoryName, image: $image, status: $status)';
  }

  @override
  List<Object> get props => [id, subCategoryName, image, status];

}


