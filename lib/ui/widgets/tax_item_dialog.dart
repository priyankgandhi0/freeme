import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

class TaxItemDialog extends StatelessWidget {
  const TaxItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                taxedItem
                    .text(
                  fontSize: 18,
                  weight: FontWeight.w500,
                )
                    .paddingOnly(
                  top: screenHPadding16.sh(),
                  bottom: screenHPadding16.sh(),
                ),
              ],
            ),
            FmImage.assetImage(
              path: Assets.iconsCloseIcon,
              fit: BoxFit.fill,
              size: 12,
            )
                .onClick(
                  () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
                .paddingOnly(
              top: 22.sh(),
              right: 22.sw(),
            )
                .positioned(right: 0)
          ],
        ),
        Container(
          color: bottomLineGreyColor,
          width: Get.width,
          height: 1,
        ),
        Column(
          children: [
            Row(
              children: [
                "Type".text(
                  fontSize: 16,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Mileage".text(fontColor: greyTextColor, fontSize: 16),
                  FmImage.assetImage(
                    path: Assets.iconsDownIcon,
                    fit: BoxFit.fill,
                    size: 14,
                  )
                ],
              ).paddingOnly(
                left: screenWPadding16.sw(),
                right: screenWPadding16.sw(),
                top: screenHPadding16.sw(),
                bottom: screenHPadding16.sw(),
              ),
            ).paddingOnly(
              top: screenHPadding8.sh(),
            )
          ],
        ).paddingOnly(
          left: screenWPadding32.sw(),
          right: screenWPadding32.sw(),
          top: screenHPadding16.sh(),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Amount".text(
                    fontSize: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: FmEmptyTextField(
                      hintText: "\$25",
                    ).paddingOnly(
                      top: screenWPadding16.sw(),
                      left: screenWPadding16.sw(),
                      bottom: screenHPadding16.sh(),
                    ),
                  ).paddingOnly(
                    top: screenHPadding8.sh(),
                  )
                ],
              ).paddingOnly(right: 16),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  per.text(
                    fontSize: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        day.text(
                          fontSize: 16,
                          fontColor: greyTextColor,
                        ),
                        FmImage.assetImage(
                          path: Assets.iconsDownIcon,
                          height: 15.sh(),
                          width: 15.sw(),
                        )
                      ],
                    ).paddingOnly(
                      top: screenHPadding16.sh(),
                      bottom: screenHPadding16.sh(),
                      left: screenWPadding16.sw(),
                      right: screenWPadding16.sw(),
                    ),
                  ).paddingOnly(
                    top: screenHPadding8.sh(),
                  )
                ],
              ),
            ),
          ],
        ).paddingOnly(
          left: screenWPadding32.sw(),
          right: screenWPadding32.sw(),
          top: screenHPadding16.sh(),
        ),
        FmButton(
          ontap: () {},
          name: add,
        ).paddingOnly(
          top: 24.sh(),
          bottom: 24.sh(),
          left: screenWPadding32.sw(),
          right: screenWPadding32.sw(),
        )
      ],
    );
  }
}
