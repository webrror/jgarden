import 'dart:convert';

import 'package:jgarden/models/rating.dart';

class Product {
  final String name;
  final String description;
  final String category;
  final double price;
  final double quantity;
  final List<String> images;
  final String? id;
  final bool isActive;
  final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.quantity,
    required this.images,
    this.isActive = true,
    this.id,
    this.rating
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'category': category});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'images': images});
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'isActive': isActive});
    if(rating != null){
      result.addAll({'rating': rating!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      id: map['_id'],
      isActive: map['isActive'] ?? false,
      rating: map['ratings'] != null ? List<Rating>.from(map['ratings']?.map((x) => Rating.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

