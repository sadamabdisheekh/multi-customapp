import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'store_item.dart';

class CartResponseModel extends Equatable {
  final int id;
  final int quantity;
  final int price;
  final StoreItem storeItem;
  const CartResponseModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.storeItem,
  });
 

  CartResponseModel copyWith({
    int? id,
    int? quantity,
    int? price,
    StoreItem? storeItem,
  }) {
    return CartResponseModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      storeItem: storeItem ?? this.storeItem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'price': price,
      'storeItem': storeItem.toMap(),
    };
  }

  factory CartResponseModel.fromMap(Map<String, dynamic> map) {
    return CartResponseModel(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
      storeItem: StoreItem.fromMap(map['storeItem'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartResponseModel.fromJson(String source) => CartResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, quantity, price, storeItem];
}
