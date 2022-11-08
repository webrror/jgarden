import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jgarden/admin/pages/add_product.dart';
import 'package:jgarden/admin/pages/admin_main_page.dart';
import 'package:jgarden/models/product_model.dart';
import 'package:jgarden/pages/address/address.dart';
import 'package:jgarden/pages/auth/auth_screen.dart';
import 'package:jgarden/pages/categories/category_deals.dart';
import 'package:jgarden/pages/home/homePage.dart';
import 'package:jgarden/pages/home/search.dart';
import 'package:jgarden/pages/mainPage.dart';
import 'package:jgarden/pages/product/product_page.dart';
import 'package:jgarden/pages/product/rate_product_page.dart';
import 'package:jgarden/pages/profile/all_orders.dart';
import 'package:jgarden/pages/profile/order_detail.dart';
import 'package:jgarden/pages/profile/purchase_detail.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:lottie/lottie.dart';

import 'models/order.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    print('This is route: ${routeSettings.name}');
    switch (routeSettings.name) {
      case '/':
        return MainPage.route();
      case MainPage.routeName:
        return MainPage.route();
      case AuthScreen.routeName:
        return AuthScreen.route();
      case AddProduct.routeName:
        return AddProduct.route();
      case AdminMainPage.routeName:
        return AdminMainPage.route();
      case CategoryDeals.routeName:
        var category = routeSettings.arguments as String;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDeals(
            category: category,
          ),
        );
      case Search.routeName:
        var searchQuery = routeSettings.arguments as String;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Search(
            searchQuery: searchQuery,
          ),
        );
      case ProductPage.routeName:
        var searchQuery = routeSettings.arguments as Product;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductPage(
            product: searchQuery,
          ),
        );
        case RateProductPage.routeName:
        var product = routeSettings.arguments as Product;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => RateProductPage(
            product: product,
          ),
        );
        case AddressScreen.routeName:
        var totalAmount = routeSettings.arguments as String;
          return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
            totalAmount: totalAmount,
          ),
        );
      case AllOrders.routeName:
        return AllOrders.route();
      case OrderDetail.routeName:
        var order = routeSettings.arguments as Order;
          return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetail(order: order,),
        );
      case PurchaseDetail.routeName:
        var order = routeSettings.arguments as Order;
          return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => PurchaseDetail(order: order,),
        );
      default:
        return _errorRoute();
    }
  }

  static _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/notfound.json'
              ),
              SizedBox(height: Dimensions.height20,),
              BigText(text: 'Page not found')
            ],
          ),
        )
      ),
    );
  }
}
