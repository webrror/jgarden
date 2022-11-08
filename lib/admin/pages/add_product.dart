import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/admin/services/admin_services.dart';
import 'package:jgarden/admin/widgets/admin_app_bar.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/utils/pick_images.dart';
import 'package:jgarden/widgets/custom_button.dart';
import 'package:jgarden/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/user_provider.dart';
import '../../utils/snackbar.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  static const String routeName = '/add-product';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AddProduct(),
    );
  }

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  PageController carouselController = PageController();
  var _carouselIndex = 0.0;
  final AdminServices adminServices = AdminServices();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String defCategory = 'Fruit Plants';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    carouselController.addListener(() {
      setState(() {
        _carouselIndex = carouselController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> categories = [
    'Fruit Plants',
    'Flowering Plants',
    'Herbal Plants'
  ];

  void addProduct() async {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.addProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: defCategory,
        images: images,
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a product',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  images.isNotEmpty
                      ? Column(
                          children: [
                            CarouselSlider(
                              items: images.map((i) {
                                return Column(
                                  children: [
                                    Builder(
                                      builder: (BuildContext context) =>
                                          Image.file(
                                        i,
                                        fit: BoxFit.cover,
                                        height: Dimensions.height150,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                              options: CarouselOptions(
                                  viewportFraction: 1,
                                  height: Dimensions.height150,
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
                              dotsCount: images.length,
                              position: _carouselIndex,
                              decorator: DotsDecorator(
                                  activeColor: AppColors.mainColor,
                                  activeSize: const Size(12, 9),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            )
                          ],
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                              color: Colors.black87,
                              radius: Radius.circular(Dimensions.radius10),
                              borderType: BorderType.RRect,
                              dashPattern: [10, 5],
                              child: Container(
                                width: double.infinity,
                                height: Dimensions.height150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.photo_on_rectangle,
                                      size: 36,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    Text(
                                      'Select product images',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black26),
                                    )
                                  ],
                                ),
                              )),
                        ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  CustomTextFeild(
                      controller: productNameController,
                      hintText: 'Product Name',
                      icon: Icon(CupertinoIcons.tag)),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  CustomTextFeild(
                      maxLines: 7,
                      controller: descriptionController,
                      hintText: 'Description',
                      icon: Icon(CupertinoIcons.info)),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  CustomTextFeild(
                      controller: priceController,
                      hintText: 'Price',
                      icon: Icon(Icons.currency_rupee_rounded)),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  CustomTextFeild(
                      controller: quantityController,
                      hintText: 'Quantity',
                      icon: Icon(CupertinoIcons.number)),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField2(
                      buttonWidth: double.infinity,
                      focusColor: AppColors.mainColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8.0),
                        isDense: false,
                        filled: true,
                        fillColor: Colors.white24,
                        prefixIcon: Icon(CupertinoIcons.tray),
                        // prefixIcon: Icon(
                        //   icon,
                        //   color: Colors.grey.shade400,
                        // ),
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
                      isExpanded: true,
                      value: defCategory,
                      icon: const Icon(
                        CupertinoIcons.chevron_down,
                        size: 18,
                      ),
                      items: categories.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          defCategory = newVal!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  CustomButton(
                      text: 'Add',
                      onTap: () {
                        addProduct();
                      })
                ],
              ),
            )),
      ),
    );
  }
}
