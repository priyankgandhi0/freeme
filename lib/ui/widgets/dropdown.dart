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
    if(i==(items ?? []).length-1){
      children.add(DropdownMenuItem<MenuItem>(
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
      ));
    }else{
      children.add(DropdownMenuItem<MenuItem>(
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
      ));
    }

  }
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      customButton: child,
      items: [
        ...children
      ],
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
        scrollPadding: const EdgeInsets.all(4),
        scrollbarTheme: const ScrollbarThemeData(
          radius: Radius.circular(50),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(padding: EdgeInsets.zero, height: 58),
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
      Text(
        item.text ?? "",
        style: const TextStyle(
          color: Colors.black,
        ),
      )
    ],
  );
  /* return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
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
          Text(
            item.text ?? "",
            style: const TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),

      Container(
        color: borderGreyColor,
        width: Get.width,
        height: 1,
      )
    ],
  );*/
}

class MenuItem {
  String? text;
  num? id;
  bool isSelected;

  MenuItem({
    this.text,
    this.id,
    this.isSelected = false,
  });
}
