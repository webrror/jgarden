import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:jgarden/pages/product/product_page.dart';
import 'package:jgarden/pages/services/search_services.dart';
import 'package:jgarden/widgets/loader.dart';
import 'package:jgarden/widgets/searched_product_card.dart';
import 'package:lottie/lottie.dart';

import '../../models/product_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/xl_text.dart';

class Search extends StatefulWidget {
  static const String routeName = '/search';
  final String searchQuery;
  const Search({super.key, required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Product>? products = [];
  String query = '';
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    fetchSearchProduct();
    query = widget.searchQuery;
    super.initState();
  }

  fetchSearchProduct() async {
    products = await searchServices.fetchSearchProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void newSearch(String searchQuery) async {
    products = await searchServices.fetchSearchProduct(
        context: context, searchQuery: searchQuery);
    setState(() {
      query = searchQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController =
        TextEditingController(text: query);
    return Scaffold(
      appBar: AppBar(
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
              text: "Search",
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TextFormField(
                    onFieldSubmitted: newSearch,
                    maxLines: 1,
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0.0),
                      isDense: false,
                      filled: true,
                      fillColor: Colors.white24,
                      hintText: 'Search',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey.shade400),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.mainColor, width: 2),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                    ),
                  ),
                  products!.isEmpty
                  ? SizedBox(
                    width: double.infinity,
                    height: Dimensions.screenHeight/1.5,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/animations/notfound.json'),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          BigText(text: 'No products found')
                        ],
                      ),
                  )
                  : SizedBox(
                    height: Dimensions.height10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return Bounce(
                            duration: const Duration(milliseconds: 150),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ProductPage.routeName,
                                  arguments: products![index]);
                            },
                            child: SearchedProductCard(product: products![index]));
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
