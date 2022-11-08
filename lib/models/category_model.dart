import 'package:flutter/cupertino.dart';
import 'package:jgarden/pages/auth/auth_screen.dart';

class Category {
  final String name;
  final String imageUrl;
  final String routeName;
  Category({
    required this.routeName,
    required this.imageUrl,
    required this.name,
  });

  static List<Category> category = [
    Category(
      name: 'Fruit Plants',
      imageUrl: 'assets/images/categories/fruit.jpeg',
      routeName: '',
    ),
    Category(
      name: 'Flowering Plants',
      imageUrl: 'assets/images/categories/flower.jpg',
      routeName: '',
    ),
    Category(
      name: 'Herbal Plants',
      imageUrl: 'assets/images/categories/herbal.jpg',
      routeName: '',
    ),
    // Category(
    //   name: 'Orders',
    //   icon: const Icon(
    //     CupertinoIcons.cube_box,
    //     size: 26,
    //   ),
    //   routeName: '',
    // ),
    // Category(
    //   name: 'Saved Addresses',
    //   icon: const Icon(
    //     CupertinoIcons.location,
    //     size: 26,
    //   ),
    //   routeName: '',
    // ),
  ];
}
