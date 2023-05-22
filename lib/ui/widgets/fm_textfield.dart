
import 'package:flutter/material.dart';

import '../../constant/app_string.dart';

class FmTextField extends StatefulWidget {
  TextEditingController? controller;
  TextAlign? align;
  ValueChanged<String>? onchange;
  int? maxLength;
  int? maxLines;
  FocusNode? focusNode;
  String? hint;
  TextInputType? inputType;
  Color? fillColor;
  Widget? prefixIcon;
  Widget? sufixIcon;
  Color? hintColor;
  double? hintSize;
  double? fontSize;
  double? radius;
  String? error;
  GestureTapCallback? ontap;
  bool readOnly;
  bool showCurson;
  VoidCallback? onComplete;
  TextInputAction? textInputAction;
  bool? enabled;

  FmTextField(
      {super.key,
        this.controller,
        this.align = TextAlign.start,
        this.onchange,
        this.maxLength,
        this.maxLines,
        this.inputType,
        this.hint,
        this.prefixIcon,
        this.fillColor,
        this.sufixIcon,
        this.focusNode,
        this.hintColor,
        this.hintSize,
        this.fontSize,
        this.radius,
        this.error,
        this.ontap,
        this.onComplete,
        this.readOnly = false,
        this.showCurson = true,
        this.textInputAction,
        this.enabled});

  @override
  State<FmTextField> createState() => _FmTextFieldState();
}

class _FmTextFieldState extends State<FmTextField> {
  var isShowClose = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      textAlign: widget.align!,
      enabled: widget.enabled,
      onChanged: (text) {
        if (widget.onchange != null) {
          widget.onchange!(text);
        }
      },
      maxLength: widget.maxLength,
      cursorColor: Colors.black,
      readOnly: widget.readOnly,
      showCursor: widget.showCurson,
      onEditingComplete: widget.onComplete,
      maxLines: widget.maxLines,
      keyboardType: widget.inputType,
      onTap: widget.ontap,
      style: TextStyle(
        fontSize: widget.fontSize ??18,
        fontWeight: FontWeight.normal,
        fontFamily: sfPro,
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        errorText: widget.error,
        counterText: "",
        errorStyle: const TextStyle(
          color: Colors.red,
          fontFamily: sfPro,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.hintColor ?? Colors.black,
          fontFamily: sfPro,
          fontSize: widget.hintSize ?? 18,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 5.0),
        ),
        fillColor: widget.fillColor,
        filled: true,
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.sufixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
    );
  }
}
