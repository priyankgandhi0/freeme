import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

class FmTextField extends StatefulWidget {
  TextEditingController? controller;
  String? header;
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
  bool? obSecureText;

  FmTextField(
      {super.key,
      this.controller,
      this.align = TextAlign.start,
      this.onchange,
      this.maxLength,
      this.maxLines,
      this.inputType,
      this.obSecureText,
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
      this.header,
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
    return Column(
      children: [
        widget.header != null
            ? Row(
                children: [
                  widget.header
                      .text(
                        weight: FontWeight.normal,
                        fontColor: Colors.black,
                        fontSize: 16,
                      )
                      .paddingOnly(
                        top: 8.sh(),
                      ),
                ],
              ).paddingOnly(bottom: 8.sh())
            : Container(),
        SizedBox(
          height: 51.sh(),
          child: TextField(
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            textAlign: widget.align!,
            enabled: widget.enabled,
            obscureText: widget.obSecureText ?? false,
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
            maxLines: 1,
            keyboardType: widget.inputType,
            onTap: widget.ontap,
            style: TextStyle(
              fontSize: widget.fontSize ?? 16,
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
                color: widget.hintColor ?? greyTextColor,
                fontFamily: sfPro,
                fontSize: widget.hintSize ?? 18,
                fontWeight: FontWeight.normal,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              fillColor: Colors.white,
              filled: true,
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.sw(), vertical: 13.sw()),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.sufixIcon,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
            ),
          ),
        )
      ],
    );
  }
}
