import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/pages/services/product_details_service.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:provider/provider.dart';

import '../../../utils/dimensions.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    productDetailsServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final cartProduct = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(cartProduct['product']);
    final quantity = cartProduct['quantity'];
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.height10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
        height: Dimensions.height120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              product.images[0],
              width: Dimensions.width100,
              height: Dimensions.height100,
            ),
            SizedBox(
              width: Dimensions.width15,
            ),
            Expanded(
              flex: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: Dimensions.height5,
                  ),
                  BigText(text: '\₹${product.price.toInt()}'),
                  SizedBox(
                    height: Dimensions.height5,
                  ),
                  // product.quantity == 0
                  // ? Text('Out of Stock')
                  // : Text('In Stock')
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                        color: AppColors.mainColor),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            decreaseQuantity(product);
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
                            child: quantity == 1
                            ? const Icon(
                              CupertinoIcons.delete,
                              size: 14,
                              color: Colors.white,
                            )
                            : const Icon(
                              CupertinoIcons.minus,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                            color: Colors.white,
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(quantity.toString())),
                        InkWell(
                          splashColor: AppColors.mainColor,
                          onTap: () {
                            increaseQuantity(product);
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
                            child: const Icon(
                              CupertinoIcons.plus,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
