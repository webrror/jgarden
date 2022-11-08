import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:jgarden/admin/pages/admin_main_page.dart';
import 'package:jgarden/admin/pages/all_products.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/pages/categories/categories.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/utils/error_handle.dart';
import 'package:jgarden/utils/global.dart';
import 'package:jgarden/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../models/user.dart';

class AddressServices {
  //save user address
  void saveUserAdress(
      {required BuildContext context,
      required String address,
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({'address': address}),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(res.body)['address']);

            userProvider.setUserFromModel(user);
            Navigator.popAndPushNamed(context, AdminMainPage.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalAmount': totalSum,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
