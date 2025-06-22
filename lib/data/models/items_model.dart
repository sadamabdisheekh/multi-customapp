// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ItemsModel extends Equatable {
  final int id;
  final double? price;
  final double? cost;
  final int? stock;
  final int? stockAlert;
  final Item item;
  final Store store;
  final List<StoreItemVariation>? storeItemVariation;
  const ItemsModel({
    required this.id,
    this.price,
    this.cost,
    this.stock,
    this.stockAlert,
    required this.item,
    required this.store,
    this.storeItemVariation,
  });

  ItemsModel copyWith({
    int? id,
    double? price,
    double? cost,
    int? stock,
    int? stockAlert,
    Item? item,
    Store? store,
    List<StoreItemVariation>? storeItemVariation,
  }) {
    return ItemsModel(
      id: id ?? this.id,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      stock: stock ?? this.stock,
      stockAlert: stockAlert ?? this.stockAlert,
      item: item ?? this.item,
      store: store ?? this.store,
      storeItemVariation: storeItemVariation ?? this.storeItemVariation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'cost': cost,
      'stock': stock,
      'stockAlert': stockAlert,
      'item': item.toMap(),
      'store': store.toMap(),
      'storeItemVariation': storeItemVariation?.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemsModel.fromMap(Map<String, dynamic> map) {
    return ItemsModel(
      id: map['id'] as int,
      price: map['price'] != null ? (map['price'] as num).toDouble(): null,
      cost: map['cost'] != null ? (map['cost'] as num).toDouble() : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      stockAlert: map['stockAlert'] != null ? map['stockAlert'] as int : null,
      item: Item.fromMap(map['item'] as Map<String,dynamic>),
      store: Store.fromMap(map['store'] as Map<String,dynamic>),
      storeItemVariation: map['storeItemVariation'] != null ? List<StoreItemVariation>.from((map['storeItemVariation'] as List).map<StoreItemVariation?>((x) => StoreItemVariation.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemsModel.fromJson(String source) => ItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      price,
      cost,
      stock,
      stockAlert,
      item,
      store,
      storeItemVariation,
    ];
  }
}


class Item extends Equatable {
  final int id;
  final String name;
  final String thumbnail;
  final String? description;
  final String createdAt;
  final String updatedAt;
  final List<Images>? images;
  final Category? category;
  final Brand? brand;

  const Item({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.images,
    this.category,
    this.brand,
  });

  Item copyWith({
    int? id,
    String? name,
    String? thumbnail,
    String? description,
    String? createdAt,
    String? updatedAt,
    Category? category,
    Brand? brand,
    List<Images>? images,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
      category: category ?? this.category,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'images': images?.map((x) => x.toMap()).toList(),
      'category': category?.toMap(),
      'brand': brand?.toMap(),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      thumbnail: map['thumbnail'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      category: map['category'] != null ? Category.fromMap(map['category'] as Map<String, dynamic>) : null,
      brand: map['brand'] != null ? Brand.fromMap(map['brand'] as Map<String, dynamic>) : null,
      images: map['images'] != null ? List<Images>.from((map['images'] as List<dynamic>).map<Images?>((x) => Images.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      thumbnail,
      description ?? '',
      createdAt,
      updatedAt,
      images ?? [],
      category ?? {},
      brand ?? {},
    ];
  }
}

class Images extends Equatable {
  final int id;
  final String imageUrl;

  const Images({
    required this.id,
    required this.imageUrl,
  });

  Images copyWith({
    int? id,
    String? imageUrl,
  }) {
    return Images(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': imageUrl,
    };
  }

  factory Images.fromMap(Map<String, dynamic> map) {
    return Images(
      id: map['id'] as int,
      imageUrl: map['image_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Images.fromJson(String source) =>
      Images.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Images(id: $id, imageUrl: $imageUrl)';

  @override
  List<Object> get props => [id, imageUrl];
}

class Category extends Equatable {
  final int id;
  final String name;
  const Category({
    required this.id,
    required this.name,
  });


  Category copyWith({
    int? id,
    String? name,
  }) {
    return Category(
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

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}

class Brand extends Equatable {
  final int id;
  final String name;
  const Brand({
    required this.id,
    required this.name,
  });

  Brand copyWith({
    int? id,
    String? name,
  }) {
    return Brand(
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

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}


class Store extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? logo;
  final String? latitude;
  final String? longitude;
  final String? address;

  const Store({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.logo,
    this.latitude,
    this.longitude,
    this.address,
  });

  Store copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? logo,
    String? latitude,
    String? longitude,
    String? address,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      logo: logo ?? this.logo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'logo': logo,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      logo: map['logo'] != null ? map['logo'] as String : null,
      latitude: map['latitude']?.toString(),
      longitude: map['longitude']?.toString(),
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Store(id: $id, name: $name, phone: $phone, email: $email, logo: $logo, latitude: $latitude, longitude: $longitude, address: $address)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      phone,
      email,
      logo ?? '',
      latitude ?? '',
      longitude ?? '',
      address ?? '',
    ];
  }
}


class StoreItemVariation extends Equatable {
  final int id;
  final double? price;
  final double? cost;
  final int? stock;
  final int? stockAlert;
  final String? availableFrom;
  final String? availableTo;

  const StoreItemVariation({
    required this.id,
    this.price,
    this.cost,
    this.stock,
    this.stockAlert,
    this.availableFrom,
    this.availableTo,
  });

  StoreItemVariation copyWith({
    int? id,
    double? price,
    double? cost,
    int? stock,
    int? stockAlert,
    String? availableFrom,
    String? availableTo,
  }) {
    return StoreItemVariation(
      id: id ?? this.id,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      stock: stock ?? this.stock,
      stockAlert: stockAlert ?? this.stockAlert,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'cost': cost,
      'stock': stock,
      'stockAlert': stockAlert,
      'availableFrom': availableFrom,
      'availableTo': availableTo,
    };
  }

  factory StoreItemVariation.fromMap(Map<String, dynamic> map) {
    return StoreItemVariation(
    id: map['id'] as int,
     price: map['price'] != null ? (map['price'] as num).toDouble() : null,
    cost: map['cost'] != null ? (map['cost'] as num).toDouble() : null,
    stock: map['stock'] != null ? map['stock'] as int : null,
    stockAlert: map['stockAlert'] != null ? map['stockAlert'] as int : null,
    availableFrom: map['availableFrom'] as String?,
    availableTo: map['availableTo'] as String?,
  );
  }

  String toJson() => json.encode(toMap());

  factory StoreItemVariation.fromJson(String source) => StoreItemVariation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      price ?? 0.0,
      cost ?? 0.0,
      stock  ?? 0,
      stockAlert  ?? 0,
      availableFrom ??  '',
      availableTo ?? '',
    ];
  }
}
