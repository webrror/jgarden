import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final int maxLines;
  bool isEnabled;
  CustomTextFeild(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.icon,
      this.isEnabled = true,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15.0),
        isDense: false,
        filled: true,
        fillColor: Colors.white24,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey.shade400),
        prefixIcon: icon,
        // prefixIcon: Icon(
        //   icon,
        //   color: Colors.grey.shade400,
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor, width: 2),
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
