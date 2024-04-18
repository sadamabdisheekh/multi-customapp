import 'dart:convert';

import 'package:equatable/equatable.dart';


class UserModel extends Equatable{
  final int id;
  final String name;

  const UserModel({required this.id, required this.name});

  @override
  String toString() => 'UserModel(id: $id, name: $name)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  List<Object?> get props => [id,name];
}
