import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../../constant/space_constant.dart';
import '../../../../../generated/assets.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../widgets/fm_image.dart';

class TimeCardTabScreen extends StatelessWidget {
  const TimeCardTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_timeAddressCard(), dataTableCard()],
    );
  }

  Widget _timeAddressCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          FmImage.assetImage(
            path: Assets.iconsBackwordIcon,
            height: 15,
            width: 15,
          ).paddingOnly(
            left: screenHPadding16.sw(),
          ),
          Expanded(
            child: Column(
              children: [
                "Thursday, July 21, 2022"
                    .text(
                      fontSize: 16,
                      weight: FontWeight.w500,
                    )
                    .paddingOnly(
                      top: screenHPadding16.sh(),
                    ),
                "1812 W. Burbank Ave, Burbank, CA 91506"
                    .text(fontSize: 16, fontColor: greyTextColor)
                    .paddingOnly(
                      top: screenHPadding8.sh(),
                      bottom: screenHPadding16.sh(),
                    )
              ],
            ),
          ),
          FmImage.assetImage(
                  path: Assets.iconsForwardIcon, height: 15, width: 15)
              .paddingOnly(
            right: screenHPadding16.sw(),
          )
        ],
      ),
    ).paddingOnly(
        left: screenHPadding16.sw(),
        right: screenHPadding16.sw(),
        top: 24.sh());
  }

  dataTableCard() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Day Type"
                    .text(
                      fontSize: screenWPadding16.sw(),
                      weight: FontWeight.w500,
                    )
                    .paddingOnly(
                      left: screenWPadding16.sw(),
                      top: screenHPadding16.sh(),
                      bottom: screenHPadding16.sh(),
                    ),
                "Shoot Day"
                    .text(
                      fontSize: screenWPadding16.sw(),
                      weight: FontWeight.w500,
                    )
                    .paddingOnly(
                      right: screenWPadding16.sw(),
                      top: screenHPadding16.sh(),
                      bottom: screenHPadding16.sh(),
                    ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: 5,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Call Time:".text(fontSize: 16),
                    "--:-- AM/PM".text(fontSize: 16),
                  ],
                ).paddingOnly(
                  top: screenHPadding16.sh(),
                  left: screenWPadding16.sw(),
                  right: screenWPadding16.sw(),
                ),
              );
            },
          ),
          SizedBox(
            height: screenHPadding16.sh(),
          )
        ],
      ),
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }
}
