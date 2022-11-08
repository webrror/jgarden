import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/admin/services/admin_services.dart';
import 'package:jgarden/models/order.dart';
import 'package:jgarden/pages/profile/order_detail.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:jgarden/widgets/loader.dart';

import '../../widgets/order_list_card.dart';
import '../../widgets/small_text.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order>? ordersList;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    ordersList = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ordersList == null
          ? const Loader()
          : Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,),
              child: ordersList == null
                  ? const Loader()
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              shrinkWrap: true,
                              itemCount: ordersList!.length,
                              itemBuilder: (context, index) {
                                final orderData = ordersList![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, OrderDetail.routeName, arguments: orderData);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Dimensions.height5,
                                      ),
                                      OrderListCard(
                                          orders: ordersList, index: index),
                                      SizedBox(
                                        height: Dimensions.height5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width10),
                                        child: SmallText(
                                            text:
                                                'ID : ${ordersList![index].id}'),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width10),
                                        child: SmallText(
                                            text:
                                                'User ID : ${ordersList![index].userId}'),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
            ),
    );
  }
}
