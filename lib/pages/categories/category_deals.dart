import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:glass/glass.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/pages/services/category_services.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:jgarden/widgets/loader.dart';
import '../../widgets/best_seller_card.dart';
import '../../widgets/searched_product_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/xl_text.dart';
import '../product/product_page.dart';

class CategoryDeals extends StatefulWidget {
  final String category;
  const CategoryDeals({Key? key, required this.category}) : super(key: key);
  static const String routeName = '/category-deals';

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  List<Product>? productList;
  List<Product>? productTopList;
  final CategoryServices categoryServices = CategoryServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
    fetchTopCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await categoryServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  fetchTopCategoryProducts() async {
    productTopList = await categoryServices.fetchTopCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.white.withOpacity(0.1),
        ).asGlass(
          tintColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            XlText(
              text: widget.category,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: productList == null
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height10),
                    alignment: Alignment.topLeft,
                    child: BigText(text: 'Trending'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width15),
                    child: SizedBox(
                      height: Dimensions.height250,
                      child: BestSellerCarousel(products: productTopList),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20,
                        bottom: Dimensions.height20),
                    alignment: Alignment.topLeft,
                    child: BigText(text: 'All ${widget.category}'),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productList!.length,
                        itemBuilder: (context, index) {
                          return Bounce(
                            duration: const Duration(milliseconds: 150),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ProductPage.routeName,
                                  arguments: productList![index]);
                            },
                            child: SearchedProductCard(
                                product: productList![index]),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

class BestSellerCarousel extends StatelessWidget {
  final List<Product>? products;
  const BestSellerCarousel({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.height10,
      ),
      child: Column(children: [
        InkWell(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   '/product',
            // );
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return Bounce(
                  duration: const Duration(milliseconds: 150),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductPage.routeName,
                        arguments: products![index]);
                  },
                  child: BestSellerCard(
                    product: products![index],
                  ),
                );
              },
            ),
          ),
        )
      ]),
    );
  }
}
