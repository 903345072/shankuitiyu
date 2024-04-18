import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

/// 带图标的输入框
class InputWidget extends StatefulWidget {
  final bool obscureText;

  final String? hintText;

  final Image? icon;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  final TextAlign textAlign;

  final TextEditingController? controller;

  final TextInputType? textInputType;

  final bool autofocus;

  final TextInputAction? textInputAction;

  final FocusNode? focusNode;

  final int? maxLines;

  final List<TextInputFormatter>? inputFormatters;

  InputWidget({
    Key? key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.hintStyle,
    this.controller,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.autofocus = false,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
  })  : inputFormatters = maxLines == 1
            ? (<TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter
              ]..addAll(
                inputFormatters ?? const Iterable<TextInputFormatter>.empty()))
            : inputFormatters,
        super(key: key);

  @override
  _InputWidgetState createState() => new _InputWidgetState();
}

/// State for [InputWidget] widgets.
class _InputWidgetState extends State<InputWidget> {
  _InputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      autofocus: widget.autofocus,
      keyboardType: widget.textInputType,
      cursorColor: MyColors.primary,
      style: widget.textStyle,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        hintText: widget.hintText ?? "",
        hintStyle: widget.hintStyle,
        icon: widget.icon,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
