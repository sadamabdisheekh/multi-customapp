// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:multi/data/models/items_model.dart';

class ItemDetailsModel extends Equatable {
  final int itemId;
  final int storeItemId;
  final String name;
  final String? description;
  final String thumbnail;
  final bool hasVariations;
  final double? basePrice;
  final Category? category;
  final Store store;
  final Brand? brand;
  final int? stock;
  final List<Images>? images;
  final List<Variations>? variations;
  final List<Attributes>? attributes;
  const ItemDetailsModel({
    required this.itemId,
    required this.storeItemId,
    required this.name,
    this.description,
    required this.thumbnail,
    required this.hasVariations,
    this.basePrice,
    this.category,
    required this.store,
    this.brand,
    this.stock,
    this.images,
    this.variations,
    this.attributes,
  });
  

  ItemDetailsModel copyWith({
    int? itemId,
    int? storeItemId,
    String? name,
    String? description,
    String? thumbnail,
    bool? hasVariations,
    double? basePrice,
    Category? category,
    Store? store,
    Brand? brand,
    int? stock,
    List<Images>? images,
    List<Variations>? variations,
    List<Attributes>? attributes,
  }) {
    return ItemDetailsModel(
      itemId: itemId ?? this.itemId,
      storeItemId: storeItemId ?? this.storeItemId,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      hasVariations: hasVariations ?? this.hasVariations,
      basePrice: basePrice ?? this.basePrice,
      category: category ?? this.category,
      store: store ?? this.store,
      brand: brand ?? this.brand,
      stock: stock ?? this.stock,
      images: images ?? this.images,
      variations: variations ?? this.variations,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'storeItemId': storeItemId,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'hasVariations': hasVariations,
      'basePrice': basePrice,
      'category': category?.toMap(),
      'store': store.toMap(),
      'brand': brand?.toMap(),
      'stock': stock,
      'images': images?.map((x) => x.toMap()).toList(),
      'variations': variations?.map((x) => x.toMap()).toList(),
      'attributes': attributes?.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemDetailsModel.fromMap(Map<String, dynamic> map) {
    return ItemDetailsModel(
      itemId: map['itemId'] as int,
      storeItemId: map['storeItemId'] as int,
      name: map['name'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      thumbnail: map['thumbnail'] as String,
      hasVariations: map['hasVariations'] as bool,
      basePrice: map['basePrice'] != null ? (map['basePrice'] as num).toDouble(): null,
      category: map['category'] != null ? Category.fromMap(map['category'] as Map<String,dynamic>) : null,
      store: Store.fromMap(map['store'] as Map<String,dynamic>),
      brand: map['brand'] != null ? Brand.fromMap(map['brand'] as Map<String,dynamic>) : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      images: map['images'] != null ? List<Images>.from((map['images'] as List).map<Images?>((x) => Images.fromMap(x as Map<String,dynamic>),),) : null,
      variations: map['variations'] != null ? List<Variations>.from((map['variations'] as List).map<Variations?>((x) => Variations.fromMap(x as Map<String,dynamic>),),) : null,
      attributes: map['attributes'] != null ? List<Attributes>.from((map['attributes'] as List).map<Attributes?>((x) => Attributes.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemDetailsModel.fromJson(String source) => ItemDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      itemId,
      storeItemId,
      name,
      description,
      thumbnail,
      hasVariations,
      basePrice,
      category,
      store,
      brand,
      stock,
      images,
      variations,
      attributes,
    ];
  }
}

class Attributes extends Equatable {
  final int attributeId;
  final String attributeName;
  final List<AttributeValue> values;
  const Attributes({
    required this.attributeId,
    required this.attributeName,
    required this.values,
  });

  Attributes copyWith({
    int? attributeId,
    String? attributeName,
    List<AttributeValue>? values,
  }) {
    return Attributes(
      attributeId: attributeId ?? this.attributeId,
      attributeName: attributeName ?? this.attributeName,
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attributeId': attributeId,
      'attributeName': attributeName,
      'values': values.map((x) => x.toMap()).toList(),
    };
  }

  factory Attributes.fromMap(Map<String, dynamic> map) {
    return Attributes(
      attributeId: map['attributeId'] as int,
      attributeName: map['attributeName'] as String,
      values: List<AttributeValue>.from((map['values'] as List).map<AttributeValue>((x) => AttributeValue.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attributes.fromJson(String source) => Attributes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [attributeId, attributeName, values];
}

class AttributeValue extends Equatable {
  final int valueId;
  final String attributeValue;
  const AttributeValue({
    required this.valueId,
    required this.attributeValue,
  });


  AttributeValue copyWith({
    int? valueId,
    String? attributeValue,
  }) {
    return AttributeValue(
      valueId: valueId ?? this.valueId,
      attributeValue: attributeValue ?? this.attributeValue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'valueId': valueId,
      'attributeValue': attributeValue,
    };
  }

  factory AttributeValue.fromMap(Map<String, dynamic> map) {
    return AttributeValue(
      valueId: map['valueId'] as int,
      attributeValue: map['attributeValue'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeValue.fromJson(String source) => AttributeValue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [valueId, attributeValue];
}


class Variations extends Equatable {
  final int id;
  final double? price;
  final int? stock;
  final List<dynamic>? attributeValueIds;
  const Variations({
    required this.id,
    this.price,
    this.stock,
    this.attributeValueIds,
  });
 

  Variations copyWith({
    int? id,
    double? price,
    int? stock,
    List<dynamic>? attributeValueIds,
  }) {
    return Variations(
      id: id ?? this.id,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      attributeValueIds: attributeValueIds ?? this.attributeValueIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'stock': stock,
      'attributeValueIds': attributeValueIds,
    };
  }

  factory Variations.fromMap(Map<String, dynamic> map) {
    return Variations(
      id: map['id'] as int,
      price: map['price'] != null ? (map['price'] as num).toDouble(): null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      attributeValueIds: map['attributeValueIds'] != null ? List<dynamic>.from((map['attributeValueIds'] as List<dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Variations.fromJson(String source) => Variations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, price, stock, attributeValueIds];
}
