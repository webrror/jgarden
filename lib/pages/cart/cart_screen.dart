import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jgarden/pages/address/address.dart';
import 'package:jgarden/pages/cart/widgets/cart_product.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/address_info.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:jgarden/widgets/custom_button.dart';
import 'package:jgarden/widgets/small_text.dart';

import '../../widgets/xl_text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  void navToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName, arguments: sum.toString());
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['product']['price'] * e['quantity'] as int)
        .toList();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: XlText(
            text: "Cart",
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: Column(
            children: [
              user.cart.isEmpty 
              ? SizedBox(
                width: double.infinity,
                height: Dimensions.height535,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/emptycart.json',
                      width: Dimensions.width250,
                    ),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: 'Your cart is empty')
                  ],
                ),
              )
              : 
              const AddressBox(),
              SizedBox(
                height: Dimensions.height5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: user.cart.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CartProduct(index: index);
                      }),
                ),
              ),
              SizedBox(
                height: Dimensions.height70,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.height100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(
                        10), // the color of a shadow, you can adjust it
                    spreadRadius:
                        0, //also play with this two values to achieve your ideal result
                    blurRadius: 9,
                    offset: Offset(0, -9),
                  )
                ],
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallText(text: 'Total Amount'),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      BigText(text: '\₹$sum'),
                      SizedBox(
                        height: Dimensions.height5,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      user.cart.isEmpty
                      ? CustomButton(
                          size: Dimensions.width200,
                          text: 'Proceed',
                          onTap: () {},
                          isDisabled: true,
                        )
                      : CustomButton(
                          size: Dimensions.width200,
                          text: 'Proceed',
                          onTap: () {
                            navToAddress(sum);
                          }
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
