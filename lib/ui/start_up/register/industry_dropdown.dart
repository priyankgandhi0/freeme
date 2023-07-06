import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/ui/widgets/dropdown.dart';

Widget industryDD<T>(
    {Widget? child,
    List<MenuItem>? items,
    required Function(MenuItem? item) onDropDownTap,
    required BuildContext context,
    bool showDash = false,
    double? width}) {
  List<DropdownMenuItem> children = [];
  children.clear();

  for (int i = 0; i < (items ?? []).length; i++) {
    if (i == (items ?? []).length - 1) {
      children.add(
        DropdownMenuItem<MenuItem>(
          value: items?[i],
          onTap: () {
            onDropDownTap(items?[i]);
          },
          child: Row(
            children: [
              items?[i].text.text(fontSize: 16).paddingAll(16) ?? Container(),
              const Spacer(),
              FmImage.assetImage(
                path: Assets.iconsDownIcon,
                height: 15.sh(),
                width: 15.sw(),
                color: Colors.black,
              ).paddingOnly(
                right: 16,
              )
            ],
          ),
        ),
      );
    } else {
      children.add(
        DropdownMenuItem<MenuItem>(
          value: items?[i],
          onTap: () {
            onDropDownTap(items?[i]);
          },
          child: Row(
            children: [
              items?[i].text.text(fontSize: 16).paddingAll(16) ?? Container(),
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
        openInterval: const Interval(0.0, 0.8),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        elevation: 0,
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

Widget buildItem2(
  MenuItem item,
  BuildContext context,
  bool showDash,
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
            if (showDash) ...[
              (item.text ?? "").text(
                fontColor: Colors.black,
                fontSize: 16,
              )
            ] else ...[
              (item.text?.split("-").first ?? "").text(
                fontColor: Colors.black,
                fontSize: 16,
              ),
              item.text
                      ?.replaceAll((item.text?.split("-").first ?? ""), "")
                      .replaceFirst("-", "")
                      .text(
                        fontColor: greyTextColor,
                      ) ??
                  Container(),
              /* (item.text?.split("-").last ?? "").text(
                fontColor: greyTextColor,
              )*/
            ],
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