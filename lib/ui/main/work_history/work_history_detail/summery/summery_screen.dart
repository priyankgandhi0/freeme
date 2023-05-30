import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freeme/globle.dart';
import 'package:get/get.dart';

import '../../../../../constant/space_constant.dart';
import '../../../../widgets/fm_dialog.dart';

class SummeryScreen extends StatelessWidget {
  const SummeryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _summeryCard(),
          _indicators(),
          _grossEnrningCard(),
          _comments(),
          _buttons(context)
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FmButton(
            ontap: () {
              showExportTimeCardDialog(context);
            },
            name: exportTimecard,
          ).paddingOnly(
            right: screenWPadding8.sw(),
          ),
        ),
        Expanded(
          child: FmButton(
            ontap: () {
              showExportInvoiceDialog(context);
            },
            name: exportInvoice,
          ).paddingOnly(
            left: screenWPadding8.sw(),
          ),
        )
      ],
    ).paddingOnly(
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
        top: 24.sh(),
        bottom: screenWPadding32.sh());
  }

  Widget _comments() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              "Comments".text(
                fontSize: 16,
              )
            ],
          ),
          FmEmptyTextField(
            hintText: commentDescription,
            maxLines: 3,
          ).paddingOnly(
            top: screenHPadding8.sh(),
          )
        ],
      ).paddingAll(16),
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
      bottom: screenHPadding16.sw(),
    );
  }

  Widget _summeryCard() {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      bottom: screenHPadding16.sh(),
      left: screenWPadding16.sh(),
      right: screenWPadding16.sh(),
    );
  }

  Widget _indicators() {
    return Container();
  }

  Widget _grossEnrningCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: darkGreenColor2,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FmImage.assetImage(
                      path: Assets.iconsDownIcon,
                      height: 15.sh(),
                      width: 14.sw(),
                      color: Colors.white,
                    ),
                    "Gross Earnings:"
                        .text(
                          fontSize: 16,
                          fontColor: Colors.white,
                          weight: FontWeight.w500,
                        )
                        .paddingOnly(
                          left: 18.sw(),
                        )
                  ],
                ),
                "\$2510.50".text(
                  fontSize: 16,
                  weight: FontWeight.w500,
                  fontColor: Colors.white,
                ),
              ],
            ).paddingAll(16),
          ),
          _grossEarningItem(name: "Wages", quantity: "750/10", price: "\$250"),
          _grossEarningItem(
              name: "Monitor", quantity: "250/Day", price: "\750"),
          _grossEarningItem(name: "Kit Fee", quantity: "75/Day", price: "\150"),
          _grossEarningItem(
              name: "Cart Fee", quantity: "50/Day", price: "\$200"),
          _grossEarningItem(name: "Mileage", quantity: " ", price: "\82.50"),
          Container(
            width: Get.width,
            height: 1,
            color: Colors.black,
          ),
          _totalEarningItem()
        ],
      ),
    ).paddingOnly(
      left: 16,
      right: 16,
    );
  }

  Widget _totalEarningItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Gross Earnings:".text(fontSize: 16),
              "\$2510.50".text(fontSize: 16),
            ],
          ),
        ),
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding8.sh(),
      bottom: screenHPadding8.sh(),
    );
  }

  Widget _grossEarningItem({String? name, String? quantity, String? price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            name.text(fontSize: 16),
            quantity.text(fontSize: 16),
          ],
        )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              price.text(fontSize: 16),
            ],
          ),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding8.sh(),
      bottom: screenHPadding8.sh(),
    );
  }

  showExportTimeCardDialog(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: screenWPadding16.sw(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  exportTimecard
                      .text(
                        fontSize: 18,
                        weight: FontWeight.w500,
                      )
                      .paddingOnly(
                        top: screenHPadding16.sh(),
                        bottom: screenHPadding8.sh(),
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
                    top: 20.sh(),
                    right: screenWPadding16.sw(),
                  )
                  .positioned(right: 0)
            ],
          ),
          Container(
            color: bottomLineGreyColor,
            width: Get.width,
            height: 1,
          ),
          _timeCardDialogItem(),
          _maxOutGuarHrs(),
          _incrementCard(),
          FmButton(
            ontap: () {},
            name: export,
          ).paddingOnly(
            left: 24.sw(),
            right: 24.sw(),
            bottom: 24.sw(),
          )
        ],
      ),
    );
  }

  Widget _incrementCard() {
    return _dialogCardDesign(
      child: Row(
        children: [
          increment.text(fontSize: 16),
          Expanded(
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black)),
            child: Row(
              children: [
                "Tenths".text(),
                FmImage.assetImage(
                  path: Assets.iconsDownIcon,
                  height: 15.sh(),
                  width: 15.sw(),
                )
              ],
            ).paddingOnly(
              top: 5.sh(),
              bottom: 5.sh(),
              left: 10.sw(),
              right: 10.sw(),
            ),
          )
        ],
      ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
          top: screenHPadding16.sh(),
          bottom: screenHPadding16.sh()),
    ).paddingOnly(
      left: 24.sw(),
      right: 24.sw(),
      top: screenHPadding16.sh(),
      bottom: screenHPadding16.sh(),
    );
  }

  Widget _maxOutGuarHrs() {
    return _dialogCardDesign(
      child: Row(
        children: [
          maxOutGuarHrs.text(fontSize: 16),
          Expanded(
            child: Container(),
          ),
          Theme(
            data: ThemeData(
              useMaterial3: true,
            ),
            child: Switch(
              value: true,
              onChanged: (value) {},
            ),
          )
        ],
      ).paddingOnly(
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
        top: 12.sw(),
        bottom: 12.sw(),
      ),
    ).paddingOnly(
      left: 24.sw(),
      right: 24.sw(),
      top: screenHPadding16.sh(),
    );
  }

  Widget _timeCardDialogItem() {
    return _dialogCardDesign(
      child: Row(
        children: [
          twoFourHourClock.text(fontSize: 16),
          Expanded(
            child: Container(),
          ),
          CupertinoSwitch(
            value: true,
            onChanged: (bool value) {},
          )
        ],
      ).paddingOnly(
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
        top: 12.sw(),
        bottom: 12.sw(),
      ),
    ).paddingOnly(
      left: 24.sw(),
      right: 24.sw(),
      top: screenHPadding16.sh(),
    );
  }

  Widget _dialogCardDesign({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0, 5),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: child,
    );
  }

  void showExportInvoiceDialog(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: screenWPadding16.sw(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  exportInvoice
                      .text(
                        fontSize: 18,
                        weight: FontWeight.w500,
                      )
                      .paddingOnly(
                        top: screenHPadding16.sh(),
                        bottom: screenHPadding8.sh(),
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
                    top: 20.sh(),
                    right: screenWPadding16.sw(),
                  )
                  .positioned(right: 0)
            ],
          ),
          Container(
            color: bottomLineGreyColor,
            width: Get.width,
            height: 1,
          ),
          _startEndDate(),
          _maxOutGuarHrsInvoice(),
          _incrementInvoiceCard(),
          FmButton(
            ontap: () {},
            name: export,
          ).paddingOnly(
            left: 24.sw(),
            right: 24.sw(),
            bottom: 24.sw(),
          )
        ],
      ),
    );
  }

  Widget _startEndDate() {
    return Row(
      children: [
        Expanded(
          child: _dialogCardDesign(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "07/23/22".text(),
                FmImage.assetImage(
                  path: Assets.iconsCalenderIcon,
                  fit: BoxFit.fitWidth,
                  width: 20,
                  height: 20,
                )
              ],
            ).paddingOnly(
              top: 14.sh(),
              bottom: 14.sh(),
              left: screenWPadding16.sw(),
              right: screenWPadding16.sw(),
            ),
          ),
        ),
        SizedBox(
          width: screenWPadding16.sw(),
        ),
        Expanded(
          child: _dialogCardDesign(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "07/23/22".text(),
                FmImage.assetImage(
                  path: Assets.iconsCalenderIcon,
                  fit: BoxFit.fitWidth,
                  width: 20,
                  height: 20,
                )
              ],
            ).paddingOnly(
              top: 14.sh(),
              bottom: 14.sh(),
              left: screenWPadding16.sw(),
              right: screenWPadding16.sw(),
            ),
          ),
        ),
      ],
    ).paddingOnly(
      left: 24.sw(),
      right: 24.sw(),
      top: screenHPadding16.sh()
    );
  }

  Widget _incrementInvoiceCard() {
    return _dialogCardDesign(
      child: Row(
        children: [
          increment.text(fontSize: 16),
          Expanded(
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black)),
            child: Row(
              children: [
                "Tenths".text(),
                FmImage.assetImage(
                  path: Assets.iconsDownIcon,
                  height: 15.sh(),
                  width: 15.sw(),
                )
              ],
            ).paddingOnly(
              top: 5.sh(),
              bottom: 5.sh(),
              left: 10.sw(),
              right: 10.sw(),
            ),
          )
        ],
      ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
          top: screenHPadding16.sh(),
          bottom: screenHPadding16.sh()),
    ).paddingOnly(
      left: 24.sw(),
      right: 24.sw(),
      top: screenHPadding16.sh(),
      bottom: screenHPadding16.sh(),
    );
  }

  Widget _maxOutGuarHrsInvoice() {
    return _dialogCardDesign(
      child: Row(
        children: [
          maxOutGuarHrs.text(fontSize: 16),
          Expanded(
            child: Container(),
          ),
          Theme(
            data: ThemeData(
              useMaterial3: true,
            ),
            child: Switch(
              value: true,
              onChanged: (value) {},
            ),
          )
        ],
      ).paddingOnly(
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
        top: 12.sw(),
        bottom: 12.sw(),
      ),
    ).paddingOnly(
      left: 24.sw(),
      right: 24.sw(),
      top: screenHPadding16.sh(),
    );
  }
}
