import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/pages/profile/order_detail.dart';
import 'package:jgarden/pages/services/account_services.dart';
import 'package:jgarden/widgets/loader.dart';
import 'package:jgarden/widgets/order_list_card.dart';

import '../../models/order.dart';
import '../../utils/dimensions.dart';
import '../../widgets/searched_product_card.dart';
import '../../widgets/xl_text.dart';
import '../product/product_page.dart';

class AllOrders extends StatefulWidget {
  static const String routeName = '/orders';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AllOrders(),
    );
  }

  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchUserOrders(context: context);
    setState(() {});
  }

  void navToOrderDetail(int index) {
    Navigator.pushNamed(context, OrderDetail.routeName, arguments: orders![index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ClipRRect(
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),child: Container(color: Colors.transparent),),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: false,
        titleSpacing: -20,
        title: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: XlText(
            text: "Your Orders",
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: orders == null
            ? const Loader()
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        shrinkWrap: true,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              navToOrderDetail(index);
                            },
                            child: OrderListCard(orders: orders, index: index),
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
