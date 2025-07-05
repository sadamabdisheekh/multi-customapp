// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final int id;
  final String name;
  final List<Region>? regions;
  const Country({
    required this.id,
    required this.name,
    this.regions,
  });

  Country copyWith({
    int? id,
    String? name,
    List<Region>? regions,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      regions: regions ?? this.regions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'regions': regions?.map((x) => x.toMap()).toList(),
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map['id'] as int,
      name: map['name'] as String,
      regions: map['regions'] != null ? List<Region>.from((map['regions'] as List).map<Region?>((x) => Region.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) => Country.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, regions];
}

class Region extends Equatable {
  final int id;
  final String name;
  final List<City>? cities;
  const Region({
    required this.id,
    required this.name,
    this.cities,
  });

  Region copyWith({
    int? id,
    String? name,
    List<City>? cities,
  }) {
    return Region(
      id: id ?? this.id,
      name: name ?? this.name,
      cities: cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cities': cities?.map((x) => x.toMap()).toList(),
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      id: map['id'] as int,
      name: map['name'] as String,
      cities: map['cities'] != null ? List<City>.from((map['cities'] as List).map<City?>((x) => City.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) => Region.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, cities];
}

class City extends Equatable {
  final int id;
  final String name;
  final List<Village>? villages;
  const City({
    required this.id,
    required this.name,
    this.villages,
  });

  City copyWith({
    int? id,
    String? name,
    List<Village>? villages,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      villages: villages ?? this.villages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'villages': villages?.map((x) => x.toMap()).toList(),
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] as int,
      name: map['name'] as String,
      villages: map['villages'] != null ? List<Village>.from((map['villages'] as List).map<Village?>((x) => Village.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, villages];
}

class Village extends Equatable {
  final int id;
  final String name;
  const Village({
    required this.id,
    required this.name,
  });

  Village copyWith({
    int? id,
    String? name,
  }) {
    return Village(
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

  factory Village.fromMap(Map<String, dynamic> map) {
    return Village(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Village.fromJson(String source) => Village.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
