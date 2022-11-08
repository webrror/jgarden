import 'dart:convert';

import 'package:jgarden/models/product_model.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalAmount;
  Order(this.id, this.products, this.quantity, this.address, this.userId,
      this.orderedAt, this.status, this.totalAmount);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});
    result.addAll({'quantity': quantity});
    result.addAll({'address': address});
    result.addAll({'userId': userId});
    result.addAll({'orderedAt': orderedAt});
    result.addAll({'status': status});
    result.addAll({'totalAmount': totalAmount});
  
    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      map['_id'] ?? '',
      List<Product>.from(map['products']?.map((x) => Product.fromMap(x['product']))),
      List<int>.from(map['products']?.map((x) => x['quantity'])),
      map['address'] ?? '',
      map['userId'] ?? '',
      map['orderedAt']?.toInt() ?? 0,
      map['status']?.toInt() ?? 0,
      map['totalAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
