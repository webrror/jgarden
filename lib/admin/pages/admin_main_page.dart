import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jgarden/admin/pages/all_products.dart';
import 'package:jgarden/admin/pages/analytics_page.dart';
import 'package:jgarden/admin/pages/orders_page.dart';
import 'package:jgarden/models/user.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/widgets/customAppBar.dart';
import 'package:provider/provider.dart';

import '../../pages/home/homePage.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../widgets/admin_app_bar.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);
  static const String routeName = '/admin-main';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AdminMainPage(),
    );
  }


  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int currentIndex = 0;
  final screens = [
    const AllProducts(),
    const AnalyticsPage(),
    const OrdersPage()
  ];
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: adminAppBar(currentIndex, context),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mainColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_list),
              activeIcon: Icon(CupertinoIcons.square_list_fill),
              label: 'Products'),
          // analytics
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.graph_square),
              activeIcon: Icon(CupertinoIcons.graph_square_fill),
              label: 'Analytics'),
          //orders
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cube_box),
              activeIcon: Icon(CupertinoIcons.cube_box_fill),
              label: 'Orders'),
        ],
      ),
    );
  }

}
