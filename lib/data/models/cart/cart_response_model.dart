import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:multi/data/models/cart/variation.dart';
import 'package:multi/data/models/items_model.dart';

class CartResponseModel extends Equatable {
  final int id;
  final int quantity;
  final int price;
  final StoreItemsModel storeItem;
  final Variation? variation;

  const CartResponseModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.storeItem,
    this.variation,
  });
  

  CartResponseModel copyWith({
    int? id,
    int? quantity,
    int? price,
    StoreItemsModel? storeItem,
    Variation? variation,
  }) {
    return CartResponseModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      storeItem: storeItem ?? this.storeItem,
      variation: variation ?? this.variation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'price': price,
      'storeItem': storeItem.toMap(),
      'variation': variation?.toMap(),
    };
  }

  factory CartResponseModel.fromMap(Map<String, dynamic> map) {
    return CartResponseModel(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
      storeItem: StoreItemsModel.fromMap(map['storeItem'] as Map<String,dynamic>),
      variation: map['variation'] != null
          ? Variation.fromMap(map['variation'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartResponseModel.fromJson(String source) => CartResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, quantity, price, storeItem, variation];
}



