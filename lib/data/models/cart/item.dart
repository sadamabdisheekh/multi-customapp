// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String? thumbnail;

  const Item({
    required this.id,
    required this.name,
    this.description,
    this.thumbnail,
  });

  Item copyWith({
    int? id,
    String? name,
    String? description,
    String? thumbnail,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, description ?? '', thumbnail ?? ''];
}
