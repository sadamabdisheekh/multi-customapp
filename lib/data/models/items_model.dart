// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ItemsModel extends Equatable {
  final int id;
  final String price;
  final int stock;
  final bool isAvailable;
  final Item item;
  final Store store;

  const ItemsModel({
    required this.id,
    required this.price,
    required this.stock,
    required this.isAvailable,
    required this.item,
    required this.store,
  });


  ItemsModel copyWith({
    int? id,
    String? price,
    int? stock,
    bool? isAvailable,
    Item? item,
    Store? store,
  }) {
    return ItemsModel(
      id: id ?? this.id,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
      item: item ?? this.item,
      store: store ?? this.store,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'stock': stock,
      'isAvailable': isAvailable,
      'item': item.toMap(),
      'store': store.toMap(),
    };
  }

  factory ItemsModel.fromMap(Map<String, dynamic> map) {
    return ItemsModel(
      id: map['id'] as int,
      price: map['price'] as String,
      stock: map['stock'] as int,
      isAvailable: map['isAvailable'] as bool,
      item: Item.fromMap(map['item'] as Map<String,dynamic>),
      store: Store.fromMap(map['store'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemsModel.fromJson(String source) => ItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemsModel(id: $id, price: $price, stock: $stock, isAvailable: $isAvailable, item: $item, store: $store)';
  }


  @override
  List<Object> get props {
    return [
      id,
      price,
      stock,
      isAvailable,
      item,
      store,
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

  const Item({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.images,
  });

 
  

  Item copyWith({
    int? id,
    String? name,
    String? thumbnail,
    String? description,
    String? createdAt,
    String? updatedAt,
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
      images: map['images'] != null ? List<Images>.from((map['images'] as List<dynamic>).map<Images?>((x) => Images.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, thumbnail: $thumbnail, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, images: $images)';
  }



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

  factory Images.fromJson(String source) => Images.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Images(id: $id, imageUrl: $imageUrl)';


  @override
  List<Object> get props => [id, imageUrl];
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

  factory Store.fromJson(String source) => Store.fromMap(json.decode(source) as Map<String, dynamic>);

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
