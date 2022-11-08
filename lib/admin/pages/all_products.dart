import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/admin/pages/add_product.dart';
import 'package:jgarden/admin/services/admin_services.dart';
import 'package:jgarden/models/models.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/loader.dart';
import 'package:jgarden/widgets/single_product.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navToAddPRoduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black26)),
                      child: Column(
                        children: [
                          Flexible(
                            child: SizedBox(
                              child: SingleProduct(
                                image: productData.images[0],
                                name: productData.name,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    
                                  },
                                  icon: Icon(CupertinoIcons.pen)),
                              IconButton(
                                  color: Colors.redAccent,
                                  onPressed: () =>
                                      deleteProduct(productData, index),
                                  icon: Icon(CupertinoIcons.delete)),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                CupertinoIcons.add
              ),
              tooltip: 'Add a product',
              onPressed: () {
                navToAddPRoduct();
              },
              backgroundColor: AppColors.mainColor,
            ),
          );
  }
}
