// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:jgarden/widgets/small_text.dart';

// import '../utils/colors.dart';
// import '../utils/dimensions.dart';
// import 'big_text.dart';
// import 'icon_and_text_widget.dart';

// class AppColumn extends StatelessWidget {
//   final String text;
//   const AppColumn({Key? key, required this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       BigText(
//         text: text,
//         size: Dimensions.font26,
//       ),
//       SizedBox(
//         height: Dimensions.height10,
//       ),
//       Row(
//         children: [
//           Wrap(
//             children: List.generate(
//                 5,
//                 (index) => Icon(
//                       Icons.star,
//                       color: AppColors.mainColor,
//                       size: 14,
//                     )),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           SmallText(text: "4.9"),
//           SizedBox(
//             width: 10,
//           ),
//           SmallText(text: "128 comments"),
//           SizedBox(
//             width: 10,
//           ),
//         ],
//       ),
//       SizedBox(
//         height: Dimensions.height20,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconAndTextWidget(
//               icon: Icons.circle,
//               text: "Normal",
//               iconColor: AppColors.iconColor1),
//           IconAndTextWidget(
//               icon: Icons.location_on,
//               text: "1.2 KM",
//               iconColor: AppColors.mainColor),
//           IconAndTextWidget(
//               icon: Icons.access_time_rounded,
//               text: "20 min",
//               iconColor: AppColors.iconColor2),
//         ],
//       ),
//     ]);
//   }
// }
