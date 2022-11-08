import 'package:flutter/cupertino.dart';
import 'package:jgarden/pages/auth/auth_screen.dart';

import '../pages/profile/all_orders.dart';

class ProfileOption {
  final String name;
  final Icon icon;
  final String routeName;
  ProfileOption({
    required this.routeName,
    required this.icon,
    required this.name,
  });

  static List<ProfileOption> option = [
    ProfileOption(
      name: 'My Profile',
      icon: const Icon(
        CupertinoIcons.person,
        size: 26,
      ),
      routeName: AuthScreen.routeName,
    ),
    ProfileOption(
      name: 'Orders',
      icon: const Icon(
        CupertinoIcons.cube_box,
        size: 26,
      ),
      routeName: AllOrders.routeName
    ),
    ProfileOption(
      name: 'Saved Addresses',
      icon: const Icon(
        CupertinoIcons.location,
        size: 26,
      ),
      routeName: '',
    ),
    ProfileOption(
      name: 'Get Help',
      icon: const Icon(
        CupertinoIcons.question_circle,
        size: 26,
      ),
      routeName: '',
    ),
    ProfileOption(
      name: 'About Us',
      icon: const Icon(
        CupertinoIcons.info_circle,
        size: 26,
      ),
      routeName: '',
    ),
    // ProfileOption(
    //   name: 'Logout',
    //   icon: const Icon(
    //     CupertinoIcons.square_arrow_right,
    //     size: 26,
    //   ),
    //   routeName: '',
    // ),
  ];
}
