import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../../../../widgets/app_calender.dart';
import '../../../../widgets/fm_dialog.dart';
import 'job_info_controller.dart';

class JobInfoScreen extends StatelessWidget {
  JobInfoScreen({Key? key}) : super(key: key);

  final controller = Get.put(JobInfoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobInfoController>(
      builder: (ctrl) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _descriptionCard(),
              _rateCard(context),
              _jobClassificationCard(),
              _taxedItem(),
              _nonTaxedItem(),
              _calender(ctrl)
            ],
          ),
        );
      },
    );
  }

  Widget _calender(JobInfoController ctrl) {
    return AppCalender(
      currentDay: controller.currentDay,
      focusDay: controller.focusedDay,
      onDaySelected: (selectedDay, focusDay) {
        controller.onDaySelect(selectedDay, focusDay);
      },
      onMonthChange: (date) {},
      selectedDays: ctrl.selectedDays,
    ).paddingOnly(
      top: screenHPadding16.sh(),
      bottom: 40.sh(),
    );
  }

  Widget _nonTaxedItem() {
    return Column(
      children: [
        Row(
          children: [
            "Non-Taxed Items".text(
              fontSize: 18,
              weight: FontWeight.w500,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              detailItem(
                title: moniter,
                desc: "\$250/Day",
              ).paddingOnly(
                top: screenHPadding16.sh(),
                bottom: screenHPadding8.sh(),
              ),
              detailItem(
                title: kitfee,
                desc: "\$20/Day",
              ).paddingOnly(
                top: screenHPadding8.sh(),
                bottom: screenHPadding8.sh(),
              ),
              detailItem(
                title: cardFee,
                desc: "\$200/Week",
              ).paddingOnly(
                top: screenHPadding8.sh(),
                bottom: screenHPadding8.sh(),
              ),
              detailItem(
                title: mileage,
                desc: "\$82.50 Flat",
              ).paddingOnly(
                top: screenHPadding8.sh(),
                bottom: screenHPadding8.sh(),
              ),
            ],
          ),
        ).paddingOnly(
          top: screenHPadding8.sh(),
        )
      ],
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _taxedItem() {
    return Column(
      children: [
        Row(
          children: [
            taxedItems.text(
              fontSize: 18,
              weight: FontWeight.w500,
            ),
          ],
        ).paddingOnly(
          top: screenHPadding16.sh(),
          bottom: screenHPadding8.sh(),
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
              "COVID Stipend".text(fontSize: 16),
              "\$250 flat".text(fontSize: 16),
            ],
          ).paddingOnly(
            left: screenWPadding16.sw(),
            right: screenWPadding16.sw(),
            top: screenHPadding16.sw(),
            bottom: screenHPadding16.sw(),
          ),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _jobClassificationCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          detailItem(
            title: jobClassification,
            desc: "Camera/1st Assist...",
            titleColor: redTextColor,
          ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: type,
            desc: "Commercial",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: unionNonUnion,
            desc: "Non-Union",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: recommendedBy,
            desc: "Erica Chan",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: hiredBy,
            desc: "Zachariah Dalton",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding16.sh(),
          ),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _rateCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          detailItem(
              title: rateStar,
              desc: "\$750/10",
              titleColor: redTextColor,
              onIbuttonClick: () {
                showDialogOnIButtonClick(context);
              }).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: guarHours,
            desc: "10 Hours",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: w21099,
            desc: "Not Sure",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: paidBy,
            desc: "Ep Services",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: terms,
            desc: "Net 15",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding16.sh(),
          ),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _descriptionCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          detailItem(
                  title: descriptionStar,
                  desc: "Commercial with Joey",
                  titleColor: redTextColor)
              .paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: title,
            desc: "Commercial#1234",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: producer,
            desc: "Full Name",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: prodCompany,
            desc: "Company, LLC",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: companyAddress,
            desc: "1234 Street Dr.Apt 111Los Angeles, CA 91506 United States ",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding16.sh(),
          ),
        ],
      ),
    ).paddingOnly(
      top: 24.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget detailItem(
      {String? title,
      String? desc,
      Color titleColor = Colors.black,
      GestureTapCallback? onIbuttonClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: title.text(
            fontSize: 16,
            fontColor: titleColor,
          ),
        ),
        onIbuttonClick != null
            ? Expanded(
                child: Row(
                  children: [
                    desc.text(fontSize: 16),
                    FmImage.assetImage(
                      path: Assets.iconsErrorIcon,
                      height: 15.sh(),
                      width: 15.sw(),
                    ).onClick(onIbuttonClick).paddingOnly(
                          left: 10.sw(),
                        )
                  ],
                ),
              )
            : Expanded(
                child: desc.text(fontSize: 16),
              ),
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _detailCard() {
    return Container();
  }

  void showDialogOnIButtonClick(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: 48,
      border: Border.all(
        color: Colors.black,
        width: 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          detailItem(
            title: rateStar,
            desc: "750 / 10",
          ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
          ),
          Container(
            width: Get.width,
            height: 1,
            color: Colors.black,
          ),
          detailItem(
            title: hourly,
            desc: "59.0909",
          ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: hourlyX15,
            desc: "88.6363",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: Hourly20,
            desc: "88.6363",
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
        ],
      ),
    );
  }
}
