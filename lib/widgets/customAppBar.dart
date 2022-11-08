import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jgarden/widgets/small_text.dart';

import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

AppBar customAppBar(User user, String appBarType) {
    return AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            titleSpacing: Dimensions.width20,
            title: appBarType == 'home' ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(
                    text: "Hello!",
                    color: AppColors.mainColor,
                  ),
                  SmallText(
                    text: user.name.toString(),
                    color: Colors.black,
                  )
                ],
              )
            :
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BigText(
                    text: "Hello, ${user.name.toString()}",
                    color: Colors.black,
                  ),
                ],
              )
            ,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        CupertinoIcons.location,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width5,
                    ),
                    SmallText(
                      text: "Kochi",
                      color: Colors.black,
                    )
                  ],
                ),
              )
            ]);
  }