import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  bool isDisabled;
  double size;

  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isDisabled = false,
    this.size = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled == false ? onTap : null,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          minimumSize: size == double.infinity
              ? const Size(double.infinity, 50)
              : Size(size, 50),
          primary: AppColors.mainColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius10))),
    );
  }
}
