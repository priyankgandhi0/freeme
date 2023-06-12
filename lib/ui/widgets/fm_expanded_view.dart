import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globle.dart';

class fMExpandedView extends StatefulWidget {
  String? title;
  String? description;
  List<String>? childList;
  Function()? onTap;
  Function(int index)? onChildTap;

  fMExpandedView(
      {Key? key,
      this.title,
      this.description,
      this.childList,
      this.onTap,
      this.onChildTap})
      : super(key: key);

  @override
  State<fMExpandedView> createState() => _fMExpandedViewState();
}

class _fMExpandedViewState extends State<fMExpandedView> {
  var isExpanded = false;

  void expansionChange(bool value) {
    isExpanded = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childList = [];
    if (widget.childList != null && widget.childList!.isNotEmpty) {
      for (int i = 0; i < widget.childList!.length; i++) {
        childList.add(
          expandedChildItem(
            widget.childList![i],
            showBorder: i == widget.childList!.length - 1 ? false : true,
              index: i
          ),
        );
      }
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: ExpansionTile(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.title
                    .text(
                      fontSize: 16,
                      weight: FontWeight.w600,
                    )
                    .paddingOnly(top: 16),
                widget.description
                    .text(
                      fontSize: 14,
                      fontColor: greyTextColor,
                    )
                    .paddingOnly(
                      top: 8,
                      bottom: 16,
                    ),
              ],
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isExpanded
                ? FmImage.assetImage(
                    path: Assets.iconsDownIcon,
                    height: 20.sh(),
                    width: 15.sw(),
                  )
                : FmImage.assetImage(
                    path: Assets.iconsForwardIcon,
                    height: 15.sh(),
                    width: 8.sw(),
                  )
          ],
        ),
        onExpansionChanged: (value) {
          if (widget.onTap != null) {
            widget.onTap!();
          } else {
            value.debugPrint;
            expansionChange(value);
          }
        },
        children: [
          (widget.childList ?? []).isNotEmpty
              ? Container(
                  width: Get.width,
                  height: 1,
                  color: Colors.black,
                )
              : Container(),
          // ...(widget.childList ?? []).map((e) => expandedChildItem(e)).toList()
          ...childList
        ],
      ),
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
    );
  }

  Widget expandedChildItem(String name, {bool showBorder = true,int index=-1}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: showBorder
              ? const BorderSide(
                  color: borderGreyColor,
                  width: 1,
                )
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          name
              .text(
                fontSize: 16,
                weight: FontWeight.w500,
              )
              .paddingOnly(
                left: screenWPadding16.sw(),
                top: screenHPadding16.sw(),
                bottom: screenHPadding16.sw(),
              ),
        ],
      ),
    ).onTap(() {
      if (widget.onChildTap != null) {
        widget.onChildTap!(index);
      }
    });
  }
}
