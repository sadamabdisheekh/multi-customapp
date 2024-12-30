import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attribute_model.dart';
import 'items_model.dart';

class ItemDetailsModel extends Equatable {
  final ItemsModel itemStore;
  final List<Attribute> attributes;

  const ItemDetailsModel({
    required this.itemStore,
    required this.attributes,
  });

  ItemDetailsModel copyWith({
    ItemsModel? itemStore,
    List<Attribute>? attributes,
  }) {
    return ItemDetailsModel(
      itemStore: itemStore ?? this.itemStore,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemStore': itemStore.toMap(),
      'attributes': attributes.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemDetailsModel.fromMap(Map<String, dynamic> map) {
    return ItemDetailsModel(
      itemStore: ItemsModel.fromMap(map['itemStore'] as Map<String, dynamic>),
      attributes: List<Attribute>.from(
        (map['attributes'] as List<dynamic>).map<Attribute>(
          (x) => Attribute.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemDetailsModel.fromJson(String source) =>
      ItemDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemDetailsModel(itemStore: $itemStore, attributes: $attributes)';

  @override
  List<Object> get props => [itemStore, attributes];
}
