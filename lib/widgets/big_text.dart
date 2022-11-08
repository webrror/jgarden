import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;  
  
  BigText({Key? key, 
    this.color=const Color(0xFF332d2b), 
    required this.text,
    this.size=0,
    this.overflow = TextOverflow.ellipsis
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: size==0?20:size,
        fontFamily: 'Roboto'
      ),
    );
  }
}