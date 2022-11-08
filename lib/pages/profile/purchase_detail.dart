import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/order.dart';
import '../../utils/dimensions.dart';
import '../../widgets/xl_text.dart';

class PurchaseDetail extends StatefulWidget {
  const PurchaseDetail({super.key, required this.order});
  final Order order;
  static const String routeName = '/purchase-detail';
  @override
  State<PurchaseDetail> createState() => _PurchaseDetailState();
}

class _PurchaseDetailState extends State<PurchaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            text: "Purchase Details",
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:Dimensions.width20, vertical: Dimensions.height10),
          child: Column(
            children: [
              for (int i = 0; i < widget.order.products.length; i++)
                Container(
                  margin: EdgeInsets.only(bottom: Dimensions.height20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                        child: Image.network(
                          widget.order.products[i].images[0],
                          height: Dimensions.height100,
                          width: Dimensions.width100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.order.products[i].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: Dimensions.height10,),
                          Text(
                            '₹${widget.order.products[i].price.toInt()} x ${widget.order.quantity[i].toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                
            ],
          ),
        ),
      ),
    );
  }
}