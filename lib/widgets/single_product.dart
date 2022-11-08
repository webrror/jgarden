import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jgarden/utils/colors.dart';

import '../utils/dimensions.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final String name;
  const SingleProduct({
    Key? key,
    required this.image,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   border: Border.all(
      //     width: 1,
      //     color: Colors.black26
      //   )
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        children: [
          Expanded(
            child: Container(

              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              width: Dimensions.width300,
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                  width: Dimensions.width300,
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10,),
          Text(name, overflow: TextOverflow.ellipsis, maxLines: 2,),
          SizedBox(height: Dimensions.height10,),
        ],
      ),
    );
  }
}
