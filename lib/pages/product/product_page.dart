import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/pages/product/rate_product_page.dart';
import 'package:jgarden/pages/services/product_details_service.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:jgarden/widgets/custom_button.dart';
import 'package:jgarden/widgets/small_text.dart';
import 'package:jgarden/widgets/stars.dart';
import 'package:jgarden/widgets/xl_text.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  static const String routeName = '/product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double avgRating = 0;
  double myRating = 0;
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  PageController carouselController = PageController();
  var _carouselIndex = 0.0;

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

    carouselController.addListener(() {
      setState(() {
        _carouselIndex = carouselController.page!;
      });
    });
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   iconTheme: const IconThemeData(color: Colors.black),
      // ),
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  left: Dimensions.width15,
                  right: Dimensions.width15),
              child: Column(
                children: [
                  CarouselSlider(
                    items: widget.product.images.map((i) {
                      return Column(
                        children: [
                          Builder(
                            builder: (BuildContext context) => Image.network(
                              i,
                              fit: BoxFit.cover,
                              height: Dimensions.height250,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    options: CarouselOptions(
                        viewportFraction: 1,
                        height: Dimensions.height250,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _carouselIndex = index.toDouble();
                          });
                        }),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  DotsIndicator(
                    mainAxisAlignment: MainAxisAlignment.center,
                    dotsCount: widget.product.images.length,
                    position: _carouselIndex,
                    decorator: DotsDecorator(
                        size: const Size.square(5),
                        spacing: const EdgeInsets.symmetric(horizontal: 3),
                        activeColor: AppColors.mainColor,
                        activeSize: const Size(25, 5),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        XlText(text: widget.product.name),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        Text(
                          '\₹${widget.product.price.toInt()}',
                          style: TextStyle(
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        SmallText(
                          text: 'Inclusive of all taxes',
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: 'Description'),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        ReadMoreText(
                            trimLines: 3,
                            widget.product.description,
                            colorClickableText: AppColors.mainColor,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            style: const TextStyle(color: Colors.black54)),
                        // SmallText(
                        //     text: widget.product.description,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: 'Review'),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RateProductPage.routeName,
                                arguments: widget.product);
                          },
                          child: SmallText(
                            text: 'Write a review',
                            color: AppColors.mainColor,
                          ),
                        )
                        // Row(
                        //   children: [
                        //     const Stars(rating: 4.4),
                        //     SizedBox(
                        //       width: Dimensions.width10,
                        //     ),
                        //     const Icon(
                        //       CupertinoIcons.chevron_forward,
                        //       size: 20,
                        //     )
                        //   ],
                        // ),
                        //display ratings
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Stars(rating: avgRating),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        SmallText(text: avgRating.toString())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height100,
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black54,
              shape: const CircleBorder(),
              padding: EdgeInsets.all(Dimensions.height5),
            ),
            child: const Icon(CupertinoIcons.chevron_back),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10),
              child: SizedBox(
                child: widget.product.quantity == 0
                    ? CustomButton(
                        text: 'Out of stock', isDisabled: true, onTap: () {})
                    : CustomButton(
                        text: 'Add to cart',
                        onTap: () {
                          addToCart();
                        }),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
