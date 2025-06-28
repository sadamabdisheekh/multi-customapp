// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final String orderCode;
  final String totalPrice;
  final String createdAt;
  final OrderStatus orderStatus;
  final PaymentStatus paymentStatus;
  final PaymentMethod paymentMethod;
  const OrderModel({
    required this.id,
    required this.orderCode,
    required this.totalPrice,
    required this.createdAt,
    required this.orderStatus,
    required this.paymentStatus,
    required this.paymentMethod,
  });


  OrderModel copyWith({
    int? id,
    String? orderCode,
    String? totalPrice,
    String? createdAt,
    OrderStatus? orderStatus,
    PaymentStatus? paymentStatus,
    PaymentMethod? paymentMethod,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderCode: orderCode ?? this.orderCode,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderCode': orderCode,
      'totalPrice': totalPrice,
      'createdAt': createdAt,
      'orderStatus': orderStatus.toMap(),
      'paymentStatus': paymentStatus.toMap(),
      'paymentMethod': paymentMethod.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      orderCode: map['orderCode'] as String,
      totalPrice: map['totalPrice'] as String,
      createdAt: map['createdAt'] as String,
      orderStatus: OrderStatus.fromMap(map['orderStatus'] as Map<String,dynamic>),
      paymentStatus: PaymentStatus.fromMap(map['paymentStatus'] as Map<String,dynamic>),
      paymentMethod: PaymentMethod.fromMap(map['paymentMethod'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderCode,
      totalPrice,
      createdAt,
      orderStatus,
      paymentStatus,
      paymentMethod,
    ];
  }
}

class OrderStatus {
  final int id;
  final String name;
  final String description;
  final bool isFinal;
  OrderStatus({
    required this.id,
    required this.name,
    required this.description,
    required this.isFinal,
  });


  OrderStatus copyWith({
    int? id,
    String? name,
    String? description,
    bool? isFinal,
  }) {
    return OrderStatus(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isFinal: isFinal ?? this.isFinal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'isFinal': isFinal,
    };
  }

  factory OrderStatus.fromMap(Map<String, dynamic> map) {
    return OrderStatus(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      isFinal: map['isFinal'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatus.fromJson(String source) => OrderStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderStatus(id: $id, name: $name, description: $description, isFinal: $isFinal)';
  }

  @override
  bool operator ==(covariant OrderStatus other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.isFinal == isFinal;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      isFinal.hashCode;
  }
}

class PaymentStatus extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool isFinal;
  const PaymentStatus({
    required this.id,
    required this.name,
    required this.description,
    required this.isFinal,
  });

  PaymentStatus copyWith({
    int? id,
    String? name,
    String? description,
    bool? isFinal,
  }) {
    return PaymentStatus(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isFinal: isFinal ?? this.isFinal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'isFinal': isFinal,
    };
  }

  factory PaymentStatus.fromMap(Map<String, dynamic> map) {
    return PaymentStatus(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      isFinal: map['isFinal'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentStatus.fromJson(String source) => PaymentStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, description, isFinal];
}

class PaymentMethod extends Equatable {
  final int id;
  final String name;
  final bool isActive;
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.isActive,
  });

  PaymentMethod copyWith({
    int? id,
    String? name,
    bool? isActive,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isActive': isActive,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as int,
      name: map['name'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) => PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, isActive];
}
