
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jgarden/utils/colors.dart';

import '../../models/user.dart';
import '../../pages/services/account_services.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

AppBar adminAppBar(int index, BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleSpacing: Dimensions.width20,
      
      title: index == 0
      ? BigText(
          text: 'Products',
          color: Colors.black,
      )
      : index == 1
      ? BigText(
          text: 'Analytics',
          color: Colors.black,
      )
      : BigText(
          text: 'Orders',
          color: Colors.black,
      ),
      actions: <Widget>[
        IconButton(
          tooltip: 'Logout',
          icon: const Icon(CupertinoIcons.square_arrow_right, color: Colors.black,), 
          onPressed: () {
            AccountServices().logOut(context);
          },
        ),
        SizedBox(width: Dimensions.width5,)
      ],
    );
  }