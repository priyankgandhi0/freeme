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
      initState: (initState) async {
        Future.delayed(Duration.zero, () {
          controller.getJobInfo(
            jobId: 28,
          );
        });
      },
      builder: (ctrl) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _descriptionCard(ctrl),
              _rateCard(context, ctrl),
              _jobClassificationCard(ctrl),
              _taxedItem(ctrl),
              _nonTaxedItem(ctrl),
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
       // controller.onDaySelect(selectedDay, focusDay);
      },
      onMonthChange: (date) {},
      selectedDays: ctrl.selectedDays,
    ).paddingOnly(
      top: screenHPadding16.sh(),
      bottom: 40.sh(),
    );
  }

  Widget _nonTaxedItem(JobInfoController ctrl) {
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
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ctrl.jobInfo?.nonTaxes?.length ?? 0,
            itemBuilder: (context, index) {
              var data = (ctrl.jobInfo?.nonTaxes ?? [])[index];
              return detailItem(
                title: data.nonTaxtType,
                desc: "\$${data.nonTaxtAmount}/${data.nonTaxtPer}",
              ).paddingOnly(
                right: screenWPadding16.sw(),
                top: screenHPadding16.sw(),
                bottom: ((ctrl.jobInfo?.nonTaxes?.length ?? 0) - 1) == index
                    ? screenHPadding16.sw()
                    : 0,
              );
            },
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

  Widget _taxedItem(JobInfoController ctrl) {
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
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ctrl.jobInfo?.taxes?.length ?? 0,
            itemBuilder: (context, index) {
              var data = (ctrl.jobInfo?.taxes ?? [])[index];
              return detailItem(
                title: data.taxType,
                desc: "\$${data.taxAmount}/${data.taxPer}",
              ).paddingOnly(
                right: screenWPadding16.sw(),
                top: screenHPadding16.sw(),
                bottom: ((ctrl.jobInfo?.taxes?.length ?? 0) - 1) == index
                    ? screenHPadding16.sw()
                    : 0,
              );
            },
          ),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _jobClassificationCard(JobInfoController ctrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          detailItem(
            title: jobClassification,
            desc: "${ctrl.jobInfo?.department}/${ctrl.jobInfo?.position}",
            titleColor: redTextColor,
          ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: type,
            desc: ctrl.jobInfo?.type,
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: unionNonUnion,
            desc: ctrl.jobInfo?.unionNonunion,
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: recommendedBy,
            desc: ctrl.jobInfo?.recommendedBy,
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: hiredBy,
            desc: ctrl.jobInfo?.hiredBy,
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

  Widget _rateCard(BuildContext context, JobInfoController ctrl) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          detailItem(
              title: rateStar,
              desc: "\$${ctrl.jobInfo?.rate}/${ctrl.jobInfo?.perHowManyHours}",
              titleColor: redTextColor,
              onIbuttonClick: () {
                showDialogOnIButtonClick(context);
              }).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: guarHours,
            desc: ctrl.jobInfo?.guaranteedHours.toString(),
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: w21099,
            desc: ctrl.jobInfo?.w21099.toString(),
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: paidBy,
            desc: ctrl.jobInfo?.paidBy.toString(),
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: terms,
            desc: ctrl.jobInfo?.terms.toString(),
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

  Widget _descriptionCard(JobInfoController ctrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          detailItem(
                  title: descriptionStar,
                  desc: ctrl.jobInfo?.description,
                  titleColor: redTextColor)
              .paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: title,
            desc: ctrl.jobInfo?.productionTital,
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: producer,
            desc: ctrl.jobInfo?.producer,
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: prodCompany,
            desc: ctrl.jobInfo?.productionCompany,
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: companyAddress,
            desc: "${ctrl.jobInfo?.companyAddressLine1 ?? ""}"
                "\m${ctrl.jobInfo?.companyAddressLine2 ?? ""}"
                "\n${ctrl.jobInfo?.city ?? ""}${ctrl.jobInfo?.state ?? ""}"
                "${ctrl.jobInfo?.zip ?? ""}\n${ctrl.jobInfo?.country ?? ""}",
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
                    ).onTap(onIbuttonClick).paddingOnly(
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
