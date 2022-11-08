import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/utils/dimensions.dart';

import '../pages/services/product_details_service.dart';

class BestSellerCard extends StatefulWidget {
  final Product product;
  const BestSellerCard({Key? key, required this.product}) : super(key: key);

  @override
  State<BestSellerCard> createState() => _BestSellerCardState();
}

class _BestSellerCardState extends State<BestSellerCard> {
  // bool isAdded = false;
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right: Dimensions.width10),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: NetworkImage(widget.product.images[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            height: Dimensions.height60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 7.0,
                  sigmaY: 7.0,
                ),
                child: Container(
                  height: Dimensions.height55,
                  width: MediaQuery.of(context).size.width * 0.43,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      color: Colors.black54),
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimensions.width10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                            SizedBox(
                              height: Dimensions.height5,
                            ),
                            Text(
                              '\₹${widget.product.price.toInt()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        // isAdded == true
                        //     ? IconButton(
                        //         icon: const Icon(
                        //           CupertinoIcons.check_mark_circled,
                        //           color: Colors.white,
                        //         ),
                        //         onPressed: () {},
                        //       )
                        IconButton(
                          icon: const Icon(
                            CupertinoIcons.plus_circled,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            addToCart();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
