import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/admin/services/admin_services.dart';
import 'package:jgarden/models/order.dart';
import 'package:jgarden/pages/profile/purchase_detail.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:intl/intl.dart';
import 'package:jgarden/widgets/custom_button.dart';
import 'package:jgarden/widgets/small_text.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/xl_text.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key, required this.order});
  final Order order;
  static const String routeName = '/order-detail';

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final f = DateFormat('dd MMM y');
 
  int currentTrackStep = 0;
  final AdminServices adminServices = AdminServices();
  void navToPurchaseDetail() {
    Navigator.pushNamed(context, PurchaseDetail.routeName,
        arguments: widget.order);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTrackStep = widget.order.status;
  }

  // only for admins
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentTrackStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          ),
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
            text: "Order Details",
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Date'),
                        SelectableText(
                          f.format(DateTime.fromMillisecondsSinceEpoch(
                              widget.order.orderedAt)),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order ID'),
                        SelectableText(
                          widget.order.id,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Total'),
                        SelectableText(
                          '\₹${widget.order.totalAmount.toInt()}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              BigText(text: 'Purchase Details'),
              SizedBox(
                height: Dimensions.height15,
              ),
              GestureDetector(
                onTap: () {
                  navToPurchaseDetail();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Dimensions.height70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (widget.order.products.length),
                            itemBuilder: (context, proIndex) {
                              return Container(
                                margin:
                                    EdgeInsets.only(right: Dimensions.width10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.black26),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5)),
                                padding: const EdgeInsets.all(8),
                                child: Image.network(
                                  widget.order.products[proIndex].images[0],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width30,
                    ),
                    Icon(
                      CupertinoIcons.chevron_right,
                      color: AppColors.mainColor,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              BigText(text: 'Tracking'),
              SizedBox(
                height: Dimensions.height15,
              ),
              Stepper(
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin') {
                      return Padding(
                        padding: EdgeInsets.only(top: Dimensions.height10),
                        child: CustomButton(
                            text: 'Mark completed',
                            onTap: () {
                              changeOrderStatus(details.currentStep); 
                            }),
                      );
                    } else {
                      return Container();
                    }
                  },
                  currentStep: currentTrackStep,
                  steps: [
                    Step(
                        title: const Text('Order Recieved'),
                        content: SmallText(
                          text: 'Order has been recieved.',
                          color: Colors.black,
                        ),
                        isActive: currentTrackStep >= 0,
                        state: currentTrackStep > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Packed'),
                        content: SmallText(
                          text: 'Your order is being packed.',
                          color: Colors.black,
                        ),
                        isActive: currentTrackStep > 1,
                        state: currentTrackStep > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Shipped'),
                        content: SmallText(
                          text: 'Pending',
                          color: Colors.black,
                        ),
                        isActive: currentTrackStep > 2,
                        state: currentTrackStep > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Delievered'),
                        content: SmallText(
                          text: 'Pending',
                          color: Colors.black,
                        ),
                        isActive: currentTrackStep >= 3,
                        state: currentTrackStep >= 3
                            ? StepState.complete
                            : StepState.indexed),
                  ])
              // Column(
              //   children: [
              //     for (int i = 0; i < widget.order.products.length; i++)
              //       Container(
              //         margin: EdgeInsets.only(bottom: Dimensions.height10),
              //         child: Row(
              //           children: [
              //             Image.network(
              //               widget.order.products[i].images[0],
              //               height: Dimensions.height100,
              //               width: Dimensions.width100,
              //             ),
              //             SizedBox(
              //               width: Dimensions.width20,
              //             ),
              //             Expanded(
              //                 child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   widget.order.products[i].name,
              //                   style: const TextStyle(
              //                       fontWeight: FontWeight.bold, fontSize: 16),
              //                 ),
              //                 SizedBox(height: Dimensions.height10,),
              //                 Text(
              //                   'x${widget.order.quantity[i].toString()}',
              //                   style: const TextStyle(
              //                       fontWeight: FontWeight.w400, fontSize: 14),
              //                 ),
              //               ],
              //             ))
              //           ],
              //         ),
              //       ),

              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
