import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // x = 844 (height of device) / inetended size 
  // x = 390 (width of device) / inetended size 

  static double pageView = screenHeight / 2.44;

  static double pageViewContainer = screenHeight / 3.55;

  static double pageViewTextContainer = screenHeight / 6.5;

  //dynamic height p and m
  static double height5 = screenHeight / 168.8;
  static double height10 = screenHeight / 78.1;
  static double height15 = screenHeight / 52.06;
  static double height20 = screenHeight / 39.04;
  static double height30 = screenHeight / 26.03;
  static double height45 = screenHeight / 17.35;
  static double height55 = screenHeight / 15.34;
  static double height60 = screenHeight / 14.066;
  static double height70 = screenHeight / 12.075;
  static double height75 = screenHeight / 11.25;
  static double height80 = screenHeight / 10.55;
  static double height100 = screenHeight / 8.44; 
  static double height120 = screenHeight / 6;
  static double height150 = screenHeight / 5.62;
  static double height200 = screenHeight / 4.22;
  static double height250 = screenHeight / 3.36;
  static double height300 = screenHeight / 2.81;
  static double height535 = screenHeight / 1.577;
  static double height600 = screenHeight / 1.406;
  static double height700 = screenHeight / 1.205;

  //dynamic width p and m
  static double width5 = screenHeight / 156.2;
  static double width10 = screenHeight / 78.1;
  static double width15 = screenHeight / 52.06;
  static double width20 = screenHeight / 39.04;
  static double width30 = screenHeight / 26.03;
  static double width45 = screenHeight / 17.35;
  static double width55 = screenHeight / 15.34;
  static double width100 = screenHeight / 8.44;
  static double width200 = screenHeight / 4.22;
  static double width250 = screenHeight / 3.376;
  static double width300 = screenHeight / 2.81;

  //font size
  static double font20 = screenHeight / 39.04;
  static double font26 = screenHeight / 32.46;
  static double font28 = screenHeight / 30.14;
  static double font30 = screenHeight / 28.133;

  //border radius
  static double radius5 = screenHeight / 168.8;
  static double radius10 = screenHeight / 84.4;
  static double radius15 = screenHeight / 52.06;
  static double radius20 = screenHeight / 39.04;
  static double radius30 = screenHeight / 26.03;

  //icon size
  static double iconSize24 = screenHeight / 32.54;
  static double iconSize16 = screenHeight / 52.75;

  //lsit view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContainerSize = screenWidth / 3.9;

  //popular food
  static double popularFoodImgSize = screenHeight / 2.41;
}
