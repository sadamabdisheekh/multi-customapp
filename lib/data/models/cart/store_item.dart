// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:multi/data/models/cart/item.dart';

class StoreItem extends Equatable {
  final int id;
  final String price;
  final int stock;
  final Item item;
  const StoreItem({
    required this.id,
    required this.price,
    required this.stock,
    required this.item,
  });

  StoreItem copyWith({
    int? id,
    String? price,
    int? stock,
    Item? item,
  }) {
    return StoreItem(
      id: id ?? this.id,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'stock': stock,
      'item': item.toMap(),
    };
  }

  factory StoreItem.fromMap(Map<String, dynamic> map) {
    return StoreItem(
      id: map['id'] as int,
      price: map['price'] as String,
      stock: map['stock'] as int,
      item: Item.fromMap(map['item'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreItem.fromJson(String source) => StoreItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, price, stock, item];
}
