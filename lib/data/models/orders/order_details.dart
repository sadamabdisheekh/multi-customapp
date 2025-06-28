// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:multi/data/models/items_model.dart';

class OrderDetailsModel extends Equatable {
  final int orderId;
  final String price;
  final int quantity;
  final String subtotal;
  final StoreItemsModel storeItem;
   final List<ItemVariation>? variation;
  const OrderDetailsModel({
    required this.orderId,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.storeItem,
    this.variation,
  });

  OrderDetailsModel copyWith({
    int? orderId,
    String? price,
    int? quantity,
    String? subtotal,
    StoreItemsModel? storeItem,
    List<ItemVariation>? variation,
  }) {
    return OrderDetailsModel(
      orderId: orderId ?? this.orderId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
      storeItem: storeItem ?? this.storeItem,
      variation: variation ?? this.variation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'price': price,
      'quantity': quantity,
      'subtotal': subtotal,
      'storeItem': storeItem.toMap(),
      'variation': variation?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      orderId: map['orderId'] as int,
      price:    map['price'] as String,
      quantity: map['quantity'] as int,
      subtotal: map['subtotal'] as String,
      storeItem: StoreItemsModel.fromMap(map['storeItem'] as Map<String,dynamic>),
      variation: map['variation'] != null ? List<ItemVariation>.from((map['variation'] as List).map<ItemVariation?>((x) => ItemVariation.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromJson(String source) => OrderDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      orderId,
      price,
      quantity,
      subtotal,
      storeItem,
      variation,
    ];
  }
}

class ItemVariation extends Equatable {
  final int attributeId;
  final String attributeName;
  final String attributeValue;
  final int valueId;
  const ItemVariation({
    required this.attributeId,
    required this.attributeName,
    required this.attributeValue,
    required this.valueId,
  });

  ItemVariation copyWith({
    int? attributeId,
    String? attributeName,
    String? attributeValue,
    int? valueId,
  }) {
    return ItemVariation(
      attributeId: attributeId ?? this.attributeId,
      attributeName: attributeName ?? this.attributeName,
      attributeValue: attributeValue ?? this.attributeValue,
      valueId: valueId ?? this.valueId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attributeId': attributeId,
      'attributeName': attributeName,
      'attributeValue': attributeValue,
      'valueId': valueId,
    };
  }

  factory ItemVariation.fromMap(Map<String, dynamic> map) {
    return ItemVariation(
      attributeId: map['attributeId'] as int,
      attributeName: map['attributeName'] as String,
      attributeValue: map['attributeValue'] as String,
      valueId: map['valueId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemVariation.fromJson(String source) => ItemVariation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [attributeId, attributeName, attributeValue, valueId];
}
