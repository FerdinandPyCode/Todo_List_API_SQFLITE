import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign align;
  final double size;
  final FontWeight weight;
  final Color color;
  final bool isNormal;
  final int maxLines;
  final TextDecoration decoration;
  final TextOverflow overflow;

  const AppText(this.text,
      {Key? key,
      this.align = TextAlign.start,
      this.size = 15,
      this.isNormal = true,
      this.weight = FontWeight.normal,
      this.maxLines = 50,
      this.overflow = TextOverflow.visible,
      this.decoration = TextDecoration.none,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        decoration: decoration,
        fontWeight: weight,
      ),
    );
  }
}
