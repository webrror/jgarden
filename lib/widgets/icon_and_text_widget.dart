// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:jgarden/utils/dimensions.dart';
// import 'package:jgarden/widgets/small_text.dart';

// class IconAndTextWidget extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final Color iconColor;
//   const IconAndTextWidget({Key? key, required this.icon, required this.text, required this.iconColor}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: iconColor, size: Dimensions.iconSize24,),
//         SizedBox(width: Dimensions.width5,),
//         SmallText(text: text),
//       ],
//     );
//   }
// }