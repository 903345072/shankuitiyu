// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/util/rpx.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color color;
  final bool whiteColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines;
  final double leading;
  final TextDecoration decoration;

  const TextWidget(
    this.text, {
    Key? key,
    this.textAlign = TextAlign.center,
    this.color = Colors.black,
    this.whiteColor = false,
    this.fontSize = 0,
    this.fontWeight = FontWeight.w400,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.decoration = TextDecoration.none,
    this.leading = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: whiteColor ? Colors.white : color,
        fontSize: fontSize == 0 ? rpx(13) : fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
      strutStyle: StrutStyle(
        fontSize: fontSize == 0 ? rpx(13) : fontSize,
        leading: leading,
        // height: 1.0,
        forceStrutHeight: true,
      ),
    );
  }
}
