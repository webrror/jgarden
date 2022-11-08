import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:jgarden/models/models.dart';
import 'package:jgarden/pages/categories/category_deals.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/xl_text.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);


  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  void navToCategoryDeals(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDeals.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    List<Category> category = Category.category;
    return Container(
      margin:
          EdgeInsets.only(top: Dimensions.height5, bottom: Dimensions.height15),
      padding:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            titleSpacing: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XlText(
                  text: "Categories",
                  color: Colors.black,
                ),
              ],
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: Dimensions.height10),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height535,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: category.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Bounce(
                        duration: const Duration(milliseconds: 150),
                        onPressed: () {
                            navToCategoryDeals(context, category[index].name);
                          },
                        child: BuildCard(
                          category: category[index].name,
                          imageUrl: category[index].imageUrl,
                        ),
                      );
                    },
                  ),
                )
                // Container(
                //   margin: EdgeInsets.only(top: Dimensions.height10),
                //   height: 100,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     border: Border.all(width: 1, color: AppColors.mainColor),
                //     boxShadow: const[
                //       BoxShadow(
                //         color: Color(0xFFe8e8e8),
                //         blurRadius: 8.0,
                //         offset: Offset(0,5)
                //       ),
                //       BoxShadow(
                //         color: Colors.white
                //       )
                //     ],
                //     borderRadius: BorderRadius.circular(Dimensions.radius10)
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}

class BuildCard extends StatelessWidget {
  final String category;
  final String imageUrl;
  const BuildCard({
    Key? key,
    required this.category,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.radius10),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radius5),
            child: Image.asset(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: Dimensions.width20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: category),
            ],
          ),
          // SizedBox(width: Dimensions.width55,),
          const Spacer(),
          const Icon(CupertinoIcons.right_chevron)
        ],
          ),
        ),
      ),
    );
  }
}
