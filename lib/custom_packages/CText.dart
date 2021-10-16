import 'package:flutter/material.dart';


class CText extends StatelessWidget {

  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLine;
  final TextOverflow? textOverflow;


  const CText(this.text, {Key? key,this.maxLine, this.textOverflow, this.size, this.color, this.fontWeight,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: maxLine,
      style: TextStyle(

        color: color,
        overflow: textOverflow ?? TextOverflow.visible,
        fontSize: size ?? 20, fontWeight: fontWeight),);
  }
}
