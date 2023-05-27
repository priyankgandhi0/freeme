import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globle.dart';

class fMExpandedView extends StatefulWidget {
  String? title;
  String? description;
  List<String>? childList;

  fMExpandedView({
    Key? key,
    this.title,
    this.description,
    this.childList,
  }) : super(key: key);

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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
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
          value.debugPrint;
          expansionChange(value);
        },
        children: [
          (widget.childList ?? []).isNotEmpty?Container(
            width: Get.width,
            height: 1,
            color: Colors.black,
          ):Container(),
          ...(widget.childList ?? []).map((e) =>
              expandedChildItem(e)).toList()
        ],
      ),
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
    );
  }

  Widget expandedChildItem(String name) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderGreyColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          name.text(fontSize: 16, weight: FontWeight.w500).paddingOnly(
            left: screenWPadding16.sw(),
            top: screenHPadding16.sw(),
            bottom: screenHPadding16.sw(),
          ),
        ],
      ),
    ).onClick(() {
      Navigator.pushNamed(context, Routes.workHistoryDetailScreen);
    });
  }
}
