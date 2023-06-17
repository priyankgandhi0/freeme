import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../globle.dart';

Widget fmDropDown<T>(
    {Widget? child,
    List<MenuItem>? items,
    required Function(MenuItem item) onDropDownTap,
    required BuildContext context,
    double? width}) {
  List<DropdownMenuItem> children = [];
  children.clear();

  for (int i = 0; i < (items ?? []).length; i++) {
    if (i == (items ?? []).length - 1) {
      children.add(
        DropdownMenuItem<MenuItem>(
          value: items?[i],
          onTap: () {
            onDropDownTap(items[i]);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(items![i], context),
            ],
          ),
        ),
      );
    } else {
      children.add(
        DropdownMenuItem<MenuItem>(
          value: items?[i],
          onTap: () {
            onDropDownTap(items[i]);
          },
          child: Column(
            children: [
              Expanded(child: Container()),
              buildItem(items![i], context),
              Expanded(child: Container()),
              Container(
                color: borderGreyColor,
                width: Get.width,
                height: 1,
              )
            ],
          ),
        ),
      );
    }
  }
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      customButton: child,
      items: [...children],
      onChanged: (value) {},
      dropdownStyleData: DropdownStyleData(
        width: width ?? Get.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        maxHeight: 400,
        elevation: 3,
        offset: Offset(Get.width - (33 + (width ?? Get.width / 2)), 8),
        scrollPadding: const EdgeInsets.only(right: 0),
        scrollbarTheme: const ScrollbarThemeData(
          radius: Radius.circular(50),
        ),
      ),
      menuItemStyleData:
          MenuItemStyleData(padding: EdgeInsets.zero, height: 58),
    ),
  );
}

Widget buildItem(
  MenuItem item,
  BuildContext context,
) {
  return Row(
    children: [
      item.isSelected
          ? FmImage.assetImage(
              path: Assets.iconsTrueIcon,
              height: 20.sh(),
              width: 20.sw(),
            ).paddingOnly(
              right: screenWPadding16.sw(),
              left: screenWPadding16.sw(),
            )
          : Container(
              width: 52.sw(),
            ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.text?.contains("-") ?? false) ...[
            (item.text?.split("-").first ?? "").text(
              fontColor: Colors.black,
              fontSize: 16,
            ),
            (item.text?.split("-").last ?? "").text(
              fontColor: greyTextColor,
            ),
          ] else ...[
            (item.text ?? "").text(
              fontColor: Colors.black,
              fontSize: 16,
            )
          ]
        ],
      )
    ],
  );
}

class MenuItem {
  String? text;
  String? subText;
  num? id;
  bool isSelected;
  String? countryCode;

  MenuItem({
    this.text,
    this.subText,
    this.id,
    this.countryCode,
    this.isSelected = false,
  });
}
