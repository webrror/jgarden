import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/widgets/small_text.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';
import '../utils/dimensions.dart';

class OrderListCard extends StatelessWidget {
  final List<Order>? orders;
  final int index;

  const OrderListCard({super.key, required this.orders, required this.index});

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd MMM y');
    return Container( 
        margin: EdgeInsets.only(bottom: Dimensions.height5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: Dimensions.height70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                              itemCount: (orders![index].products.length > 4 ? 4 : orders![index].products.length) ,
                              itemBuilder: (context, proIndex) {
                                return Container(
                                  margin: EdgeInsets.only(right: Dimensions.width10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.black26
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.radius5)
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Image.network(
                                      orders![index].products[proIndex].images[0],
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(width: Dimensions.width30,),
                      Icon(CupertinoIcons.chevron_right, color: AppColors.mainColor,)
                    ],
                  ),
                  SizedBox(height: Dimensions.height15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(text: 'Order Placed On'),
                          Text(f.format(DateTime.fromMillisecondsSinceEpoch(
                              orders![index].orderedAt)), style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SmallText(text: 'Total Amount'),
                          Text('\₹${orders![index].totalAmount.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
