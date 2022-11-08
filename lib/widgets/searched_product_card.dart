import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/stars.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SearchedProductCard extends StatefulWidget {
  const SearchedProductCard({super.key, required this.product});
  final Product product;
  @override
  State<SearchedProductCard> createState() => _SearchedProductCardState();
}

class _SearchedProductCardState extends State<SearchedProductCard> {
  double avgRating = 0;
  double myRating = 0;
  bool isOutOfStock = false;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }

    if (widget.product.quantity == 0) {
      isOutOfStock = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width10, vertical: Dimensions.height10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                child: Image.network(
                  widget.product.images[0],
                  fit: BoxFit.cover,
                  height: Dimensions.height120,
                  width: Dimensions.width100,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Dimensions.width200,
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 150,
                    padding: EdgeInsets.only(top: 10, left: Dimensions.width20),
                    child: Stars(rating: avgRating),
                  ),
                  Container(
                    width: 150,
                    padding: EdgeInsets.only(top: 10, left: Dimensions.width20),
                    child: Text(
                      '\₹${widget.product.price}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 150,
                    padding: EdgeInsets.only(top: 10, left: Dimensions.width20),
                    child: isOutOfStock 
                    ? const Text(
                      'Out of stock',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                    : Text(
                      'In Stock',
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(CupertinoIcons.chevron_right, color: Colors.black38,)
            ],
          ),
        ),
      ],
    );
  }
}
