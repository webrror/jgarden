import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/models/user.dart';
import 'package:jgarden/pages/home/search.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../widgets/best_seller_card.dart';
import '../../widgets/big_text.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/section_header.dart';
import '../../widgets/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navToSearch(String searchQuery) {
    Navigator.pushNamed(context, Search.routeName, arguments: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final String appBarType = 'home';
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height10, bottom: Dimensions.height15),
      child: Scaffold(
          appBar: customAppBar(user, appBarType),
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.only(top: Dimensions.height15),
            padding: EdgeInsets.only(
              left: Dimensions.width20,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: Dimensions.width20),
                  child: TextFormField(
                    onFieldSubmitted: navToSearch,
                    maxLines: 1,
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
                ),
              ],
            ),
          ))),
    );
  }
}

class NewlyAddedCarousel extends StatelessWidget {
  final List<Product> products;
  const NewlyAddedCarousel({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.height20,
      ),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(right: Dimensions.width20),
          child: const SectionHeader(
            title: 'Newly Added',
          ),
        ),
        SizedBox(
          height: Dimensions.height15,
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.27,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: Product.products.length,
        //     itemBuilder: (context, index) {
        //       return BestSellerCard(
        //         product: products[index],
        //       );
        //     },
        //   ),
        // )
      ]),
    );
  }
}

// class BestSellerCarousel extends StatelessWidget {
//   final List<Product> products;
//   const BestSellerCarousel({
//     Key? key,
//     required this.products,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: Dimensions.height20,
//       ),
//       child: Column(children: [
//         Padding(
//           padding: EdgeInsets.only(right: Dimensions.width20),
//           child: const SectionHeader(
//             title: 'Best Selling',
//           ),
//         ),
//         SizedBox(
//           height: Dimensions.height15,
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               '/product',
//             );
//           },
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.27,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return BestSellerCard(
//                   product: products[index],
//                 );
//               },
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }
