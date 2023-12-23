import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle textStyle;
  final void Function()? onTap;

  const MyText({
    super.key,
    required this.text,
    required this.textStyle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 75,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Text("Chicken",style: textStyle),
        ),
    );
  }
}


