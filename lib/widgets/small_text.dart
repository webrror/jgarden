import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  
  SmallText({Key? key, 
    this.color=const Color(0xFFccc7c5), // default color
    required this.text,
    this.size=12,
    this.height=1.2
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto'
      ),
    );
  }
}