import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Color headerColor;

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
      this.headerColor = Colors.black,
      this.textInputAction = TextInputAction.done,
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
                        fontColor: widget.headerColor,
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
            inputFormatters: <TextInputFormatter>[
              if (widget.inputType != null &&
                  (widget.inputType == TextInputType.number ||
                      widget.inputType == TextInputType.phone)) ...[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
              ]
            ],
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
              //errorText: widget.error,
              counterText: "",
              /* errorStyle: const TextStyle(
                color: Colors.red,
                fontFamily: sfPro,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),*/
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: widget.hintColor ?? greyTextColor,
                fontFamily: sfPro,
                fontSize: widget.hintSize ?? 18,
                fontWeight: FontWeight.normal,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.error != null ? redColor : Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(
                  widget.radius ?? 5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.error != null ? redColor : Colors.black,
                      width: 1.0),
                  borderRadius: BorderRadius.circular(widget.radius ?? 5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.error != null ? redColor : Colors.black,
                      width: 1.0),
                  borderRadius: BorderRadius.circular(widget.radius ?? 5)),
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
        ),
        /*  widget.error != null
            ? Row(
                children: [
                  widget.error.text(fontColor: redColor),
                ],
              )
            : Container()*/
      ],
    );
  }
}

class FmEmptyTextField extends StatelessWidget {
  FmEmptyTextField(
      {Key? key,
      this.hintText,
      this.suffixIcon,
      this.maxLines,
      this.textInputType,
      this.controller,
      this.onchange,this.enable = true})
      : super(key: key);

  TextInputType? textInputType;
  String? hintText;
  Widget? suffixIcon;
  int? maxLines;
  TextEditingController? controller;
  ValueChanged<String>? onchange;
  bool enable;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enable,
      textInputAction: TextInputAction.done,
      inputFormatters: <TextInputFormatter>[
        if (textInputType != null &&
            (textInputType == TextInputType.number ||
                textInputType == TextInputType.emailAddress ||
                textInputType == TextInputType.phone)) ...[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
        ]
      ],
      onChanged: (text) {
        if (onchange != null) {
          onchange!(text);
        }
      },
      controller: controller,
      maxLines: maxLines ?? 1,
      keyboardType: textInputType,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: sfPro,
      ),
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: sfPro,
            color: greyTextColor),
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
      ),
    );
  }
}
