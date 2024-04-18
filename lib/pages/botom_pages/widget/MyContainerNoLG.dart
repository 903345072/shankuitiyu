import 'package:flutter/material.dart';
import 'colors.dart';

class MyContainerNoLG extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final double circular;
  final Color conColor;
  final Color borderColor;
  final Color txtColor;
  final EdgeInsets padding;

  MyContainerNoLG(
    this.text, {
    this.width = 82,
    this.height = 28,
    this.fontSize = 12,
    this.circular = 20.0,
    this.conColor = MyColors.white,
    this.borderColor = MyColors.red_00,
    this.txtColor = MyColors.red_00,
    this.padding = const EdgeInsets.symmetric(horizontal: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: const BoxConstraints(
        minWidth: 20,
      ),
      height: height,
      decoration: BoxDecoration(
        color: conColor,
        border: Border.all(color: borderColor, width: 0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(circular),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: txtColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
