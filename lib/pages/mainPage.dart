import 'package:badges/badges.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:jgarden/pages/cart/cart_screen.dart';
import 'package:jgarden/pages/categories/categories.dart';
import 'package:jgarden/pages/home/homePage.dart';
import 'package:jgarden/pages/profile/profile_main.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:jgarden/widgets/small_text.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => MainPage(),
    );
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const CategoriesPage(),
    const CartScreen(),
    const ProfileMain(),
  ];
  @override
  Widget build(BuildContext context) {
    final cartLen = context.watch<UserProvider>().user.cart.length;
    // print("Height : " + MediaQuery.of(context).size.height.toString());
    // print("Width : " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: customBottomNavigationBar(cartLen),
      // body:
    );
  }

  BottomNavigationBar customBottomNavigationBar(int cartLen) {
    return BottomNavigationBar(
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
      items: [
        const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_alt),
            activeIcon: Icon(CupertinoIcons.house_alt_fill),
            label: 'Home'),
        const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill),
            label: 'Categories'),
        BottomNavigationBarItem(
            icon: Badge(
                elevation: 0,
                badgeContent: Text(cartLen.toString()),
                badgeColor: AppColors.mainColor,
                child: Icon(CupertinoIcons.cart)),
            activeIcon: Badge(
                elevation: 2,
                badgeContent: Text(cartLen.toString()),
                badgeColor: AppColors.mainColor,
                child: Icon(CupertinoIcons.cart_fill)),
            label: 'Cart'),
        const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Profile'),
      ],
    );
  }
}
