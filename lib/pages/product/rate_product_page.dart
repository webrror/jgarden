import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:jgarden/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/user_provider.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';
import '../services/product_details_service.dart';

class RateProductPage extends StatefulWidget {
  final Product product;
  const RateProductPage({super.key, required this.product});
  static const String routeName = '/rate-product';
  @override
  State<RateProductPage> createState() => _RateProductPageState();
}

class _RateProductPageState extends State<RateProductPage> {
  double myRating = 0;
  final TextEditingController reviewTitleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final _addRatingFormKey = GlobalKey<FormState>();
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.product.rating!.length; i++) {
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    reviewTitleController.dispose();
    reviewController.dispose();
  }

  void addRating() async {
    if (_addRatingFormKey.currentState!.validate()) {
      productDetailsServices.rateProduct(
          context: context,
          product: widget.product,
          rating: myRating,
          reviewTitle: reviewTitleController.text,
          review: reviewController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Text(
      //     widget.pid
      //   ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'Add Review',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _addRatingFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: Dimensions.height20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      child: Image.network(
                        widget.product.images[0],
                        width: Dimensions.width100,
                        height: Dimensions.height100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    Text(
                      widget.product.name,
                      style: const TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
              BigText(text: 'Rate'),
              SizedBox(
                height: Dimensions.height10,
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RatingBar.builder(
                        glow: false,
                        initialRating: myRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                              CupertinoIcons.star_fill,
                              color: AppColors.mainColor,
                            ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            myRating = rating;
                          });
                        }),
                    const VerticalDivider(
                      color: Colors.black,
                    ),
                    BigText(text: myRating.toString())
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              // Text(ratingUpdate.toString())
              BigText(text: 'Title'),
              SizedBox(
                height: Dimensions.height5,
              ),
              SmallText(text: 'One line review'),
              SizedBox(
                height: Dimensions.height10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                controller: reviewTitleController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 15.0),
                  isDense: false,
                  filled: true,
                  fillColor: Colors.white24,
                  hintText: 'Title',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.mainColor, width: 2),
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              BigText(text: 'Review'),
              // SizedBox(height: Dimensions.height5,),
              // SmallText(text: 'Detailed review'),
              SizedBox(
                height: Dimensions.height10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter review';
                  }
                  return null;
                },                
                textAlignVertical: TextAlignVertical.center,
                maxLines: 5,
                controller: reviewController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 15.0),
                  isDense: false,
                  filled: true,
                  fillColor: Colors.white24,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.mainColor, width: 2),
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                ),
                
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.height15),
                child: CustomButton(
                    text: 'Submit review',
                    onTap: () {
                      addRating();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
