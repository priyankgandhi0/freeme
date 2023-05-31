import 'package:flutter/material.dart';

import '../../../globle.dart';
import '../../../theme/app_colors.dart';

class MenuItems {
  static List<MenuItems> firstItems = [
    MenuItems(text: "05 Hours", isSelected: false),
    MenuItems(text: "06 Hours", isSelected: false),
    MenuItems(text: "07 Hours", isSelected: false),
    MenuItems(text: "08 Hours", isSelected: true),
    MenuItems(text: "09 Hours", isSelected: false),
    MenuItems(text: "10 Hours", isSelected: false),
    MenuItems(text: "11 Hours", isSelected: false),
    MenuItems(text: "12 Hours", isSelected: false),
    MenuItems(text: "13 Hours", isSelected: false),
    MenuItems(text: "14 Hours", isSelected: false),
    MenuItems(text: "15 Hours", isSelected: false),
    MenuItems(text: "16 Hours", isSelected: false),
  ];

  static Widget buildItem(MenuItems item) {
    return Column(
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
    );
  }

  String? text;
  bool isSelected;

  MenuItems({
    this.text,
    this.isSelected = false,
  });
}
