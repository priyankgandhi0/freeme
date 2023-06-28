import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/models/summery_model.dart';
import 'package:freeme/ui/main/work_history/work_history_detail/summery/summery_calculation.dart';
import 'package:freeme/ui/main/work_history/work_history_detail/summery/summery_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../constant/space_constant.dart';
import '../../../../widgets/fm_dialog.dart';

class SummeryScreen extends StatelessWidget {
  SummeryScreen({
    Key? key,
    required this.jobId,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  final controller = Get.put(SummeryController());
  num jobId;
  String startDate;
  String endDate;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SummeryController>(
      initState: (initState) {
        controller.getSummery(jobId, startDate, endDate);
      },
      builder: (ctrl) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _summeryCard(),
              _indicators(),
              _grossEnrningCard(ctrl),
              _comments(),
              _buttons(context)
            ],
          ),
        );
      },
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

  List<Widget> pages = [
    SummeryDataTableFirst(),
    SummeryDataTableSecond(),
  ];

  Widget _summeryCard() {
    return SizedBox(
      height: 400,
      width: Get.width,
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: 2,
        onPageChanged: (int page) {
          controller.onPageChange(page);
        },
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }

  Widget _indicators() {
    return GetBuilder<SummeryController>(builder: (ctrl) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List<Widget>.generate(
            pages.length,
            (index) => InkWell(
              onTap: () {
                controller.pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: controller.activatePage == index
                      ? darkGreenColor
                      : borderGreyColor,
                ),
                width: 6,
                height: 6,
              ).paddingAll(1),
            ),
          ).toList()
        ],
      ).paddingOnly(
        top: screenHPadding8.sh(),
        bottom: screenHPadding16.sh(),
      );
    });
  }

  Widget _grossEnrningCard(SummeryController ctrl) {
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
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
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
                ("\$${ctrl.summery?.grossEarningTotal ?? ""}").toString().text(
                      fontSize: 16,
                      weight: FontWeight.w500,
                      fontColor: Colors.white,
                    ),
              ],
            ).paddingAll(16),
          ),
          ...(ctrl.summery?.grossEarnings ?? []).map(
            (e) => _grossEarningItem(
                name: e.taxedItem,
                quantity: "${e.taxtAmount}/${e.taxPerTimeCategory}",
                price: "\$250"),
          ),
          Container(
            width: Get.width,
            height: 1,
            color: Colors.black,
          ),
          _totalEarningItem(ctrl)
        ],
      ),
    ).paddingOnly(
      left: 16,
      right: 16,
    );
  }

  Widget _totalEarningItem(SummeryController ctrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: darkGreenColor2.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Gross Earnings:".text(fontSize: 16, fontColor: darkGreenColor),
              ("\$${ctrl.summery?.grossEarningTotal ?? ""}")
                  .text(fontSize: 16, fontColor: darkGreenColor),
            ],
          )),
        ],
      ).paddingOnly(
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
        top: screenHPadding16.sh(),
        bottom: screenHPadding16.sh(),
      ),
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
              quantity.text(
                fontSize: 16,
                fontColor: greyTextColor,
              ),
            ],
          ),
        ),
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
                  .paddingOnly(
                top: 20.sh(),
                right: screenWPadding16.sw(),
                left: 20.sw(),
                bottom: 20.sw(),
              )
                  .onTap(
                () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ).positioned(right: 0)
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
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              children: [
                "Tenths".text(),
                SizedBox(
                  width: 38,
                ),
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
      bottom: 24.sh(),
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
          SizedBox(
            height: 30,
            child: FittedBox(
              child: CupertinoSwitch(
                value: true,
                activeColor: greenSwitchColor,
                onChanged: (bool value) {},
              ),
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
          SizedBox(
            height: 30,
            child: FittedBox(
              child: CupertinoSwitch(
                value: true,
                activeColor: greenSwitchColor,
                onChanged: (bool value) {},
              ),
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
                  .paddingOnly(
                top: 20.sh(),
                right: screenWPadding16.sw(),
                left: screenWPadding16.sw(),
                bottom: screenWPadding16.sw(),
              )
                  .onTap(
                () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ).positioned(right: 0)
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
    ).paddingOnly(left: 24.sw(), right: 24.sw(), top: screenHPadding16.sh());
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
          SizedBox(
            height: 30,
            child: FittedBox(
              child: CupertinoSwitch(
                value: true,
                activeColor: greenSwitchColor,
                onChanged: (bool value) {},
              ),
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

class SummeryDataTableSecond extends StatelessWidget {
  SummeryDataTableSecond({Key? key}) : super(key: key);

  final controller = Get.find<SummeryController>();

  DateTime findSundayDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday));
  }

  DateTime findSaturdayDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - (dateTime.weekday + 1)));
  }

  DateTime expandingChildItem(String e) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(e.toString());
    return findSaturdayDateOfTheWeek(tempDate);
  }

  String changeToApiFormat(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SummeryController>(
      builder: (ctrl) {
        var firstDayOfWeek = findSundayDateOfTheWeek(
          expandingChildItem(ctrl.summery?.hourlySummary?[0].date ?? ""),
        );

        List<HourlySummary> myDayListList = [];
        for (int i = 0; i < 7; i++) {
          myDayListList.insert(
            i,
            HourlySummary(
              changeToApiFormat(
                firstDayOfWeek.add(
                  Duration(days: i),
                ),
              ),
            ),
          );
          (ctrl.summery?.hourlySummary ?? []).forEach(
            (element) {
              if (element.date ==
                  changeToApiFormat(firstDayOfWeek.add(Duration(days: i)))) {
                myDayListList.removeAt(i);
                myDayListList.insert(i, element);
              }
            },
          );
        }

        return Container(
          height: 355,
          width: Get.width,
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
          child: DataTable(
            columnSpacing: 10,
            horizontalMargin: 15,
            headingRowColor: MaterialStateProperty.all(darkGreenColor2),
            border: TableBorder.all(
              width: 1.0,
              color: Colors.black,
              style: BorderStyle.solid,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            headingRowHeight: 45,
            columns: [
              myDataColumn("Date"),
              myDataColumn("1x"),
              myDataColumn("1.5x"),
              myDataColumn("2x"),
              myDataColumn("MP"),
              myDataColumn("Gross\n  Wages"),
            ],
            dataRowHeight: 30,
            rows: [
              ...myDayListList.map(
                (e) {
                  var data = TableTowCalculation.calculate(e);

                  return _dataRow(
                      date: data.date,
                      color: rowCellGreyColor,
                      oneX: data.oneX?.toString(),
                      oneFiveX: data.oneFiveX?.toString(),
                      twoX: data.twoX?.toString(),
                      mp: data.mp != 0 ? data.mp.toString() : null,
                      paidHours:
                          data.paidHours != 0 ? data.paidHours?.toString() : "",
                      grossWages: data.grossWages);
                },
              ),
            ],
          ).paddingOnly(
            left: screenWPadding8.sw(),
            right: screenWPadding8.sw(),
            top: 14.sh(),
            bottom: 24.sh(),
          ),
        ).paddingOnly(
          top: screenHPadding16.sh(),
          bottom: screenHPadding16.sh(),
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
        );
      },
    );
  }
  myDataColumn(String s){
    return DataColumn(
      label: Expanded(
        child: s
            .text(
            fontSize: 14,
            align: TextAlign.center,
            weight: FontWeight.w500,
            fontColor: Colors.white)
            .paddingOnly(bottom: 5,top: 7),
      ),
    );
  }

  DataRow _dataRow(
      {String? date,
      String? oneX,
      String? oneFiveX,
      String? twoX,
      String? empty,
      String? mp,
      String? paidHours,
      String? grossWages,
      Color color = Colors.white,
      Color textColor = Colors.black,
      FontWeight weight = FontWeight.w400}) {
    return DataRow(
      color: MaterialStateProperty.all(color),
      cells: [
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              date
                  .text(
                    fontSize: 14,
                    fontColor: textColor,
                    weight: weight,
                  )
                  .center,
            ],
          ),
        ),
        DataCell(
          oneX
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        DataCell(
          oneFiveX
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        DataCell(
          twoX
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        /*DataCell(
          empty
              .text(
                fontSize: 16,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),*/
        DataCell(
          mp
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        /* DataCell(
          paidHours
              .text(
                fontSize: 16,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),*/
        DataCell(Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            grossWages
                .text(
                  fontSize: 14,
                  fontColor: textColor,
                  weight: weight,
                )
                .center,
          ],
        )),
      ],
    );
  }
}

class SummeryDataTableFirst extends StatelessWidget {
  SummeryDataTableFirst({Key? key}) : super(key: key);

  final controller = Get.find<SummeryController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SummeryController>(
      builder: (ctrl) {
        return Container(
          height: 355,
          width: Get.width,
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
          child: Column(
            children: [
              DataTable(
                columnSpacing: 20,
                horizontalMargin: 15,
                headingRowColor: MaterialStateProperty.all(darkGreenColor2),
                border: TableBorder.all(
                  width: 1.0,
                  color: Colors.black,
                  style: BorderStyle.solid,
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                headingRowHeight: 43,
                columns: [

                  myDataColumn("Date"),
                  myDataColumn("Call"),
                  myDataColumn("Out"),
                  myDataColumn("In"),
                  myDataColumn("Out"),
                  myDataColumn("In"),
                  myDataColumn("Wrap"),

                ],
                dataRowHeight: 32,
                rows: [
                  /* ...(ctrl.summery?.hourlySummary ?? []).map(
                    (e) => _dataRow(
                      date: changeToMyFormat(e),
                      color: rowCellGreyColor,
                    ),
                  ),*/
                  _dataRow(
                    date: "7/17",
                    color: rowCellGreyColor,
                  ),
                  _dataRow(
                    date: "7/18",
                  ),
                  _dataRow(
                    date: "7/19",
                    color: rowCellGreyColor,
                    call: "9.0",
                    outOne: '15.0',
                    inOne: '15.5',
                    outTwo: '',
                    inTwo: '',
                    wrap: '21.5',
                  ),
                  _dataRow(
                    date: "7/20",
                    call: "9.0",
                    outOne: '15.5',
                    inOne: '16',
                    outTwo: '',
                    inTwo: '',
                    wrap: '22',
                  ),
                  _dataRow(
                    date: "7/21",
                    color: rowCellGreyColor,
                  ),
                  _dataRow(
                    date: "7/22",
                  ),
                  _dataRow(
                    date: "7/23",
                    color: rowCellGreyColor,
                  ),
                ],
              ).paddingOnly(
                top: 14.sh(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  "View:".text(fontSize: 20, weight: FontWeight.w500),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      children: [
                        "Tenths".text(fontSize: 16),
                        SizedBox(
                          width: 38,
                        ),
                        FmImage.assetImage(
                          path: Assets.iconsDownIcon,
                          height: 15.sh(),
                          width: 15.sw(),
                        )
                      ],
                    ).paddingOnly(left: 10, top: 5, bottom: 5, right: 10),
                  )
                ],
              ).paddingOnly(
                top: 24.sh(),
                right: 10.sw(),
              )
            ],
          ),
        ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
            left: screenWPadding16.sw(),
            right: screenWPadding16.sw());
      },
    );
  }

  myDataColumn(String s){
    return DataColumn(
      label: Expanded(
        child: s
            .text(
            fontSize: 14,
            align: TextAlign.center,
            weight: FontWeight.w500,
            fontColor: Colors.white)
            .paddingOnly(bottom: 5,top: 15),
      ),
    );
  }

  String changeToMyFormat(HourlySummary e) {
    return "${e.date?.split("-")[1]}/${e.date?.split("-").last}";
  }

  DataRow _dataRow(
      {String? date,
      String? call,
      String? outOne,
      String? inOne,
      String? outTwo,
      String? inTwo,
      String? wrap,
      Color color = Colors.white,
      Color textColor = Colors.black,
      FontWeight weight = FontWeight.w400}) {
    return DataRow(
      color: MaterialStateProperty.all(color),
      cells: [
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            date
                .text(
                  fontSize: 14,
                  fontColor: textColor,
                  weight: weight,
                )
                .center,
          ],
        )),
        DataCell(
          call
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        DataCell(
          outOne
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        DataCell(
          inOne
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        DataCell(
          outTwo
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        DataCell(
          inTwo
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
        DataCell(
          wrap
              .text(
                fontSize: 14,
                fontColor: textColor,
                weight: weight,
              )
              .center,
        ),
      ],
    );
  }
}
