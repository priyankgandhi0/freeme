import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/models/get_job_info_model.dart';

import '../../../../widgets/app_calender.dart';
import '../../../../widgets/fm_dialog.dart';
import 'job_info_controller.dart';

class JobInfoScreen extends StatelessWidget {
  JobInfoScreen({Key? key, required this.jobId}) : super(key: key);

  final controller = Get.put(JobInfoController());
  int jobId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobInfoController>(
      initState: (initState) async {
        Future.delayed(Duration.zero, () {
          controller.getJobInfo(
            jobId: jobId,
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
                title: data.taxedItem,
                desc: "\$${data.nonTaxtAmount}/${data.taxPerTimeCategory}",
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
                title: data.taxedItem,
                desc: "\$${data.taxtAmount}/${data.taxPerTimeCategory}",
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
            desc:
                "${ctrl.jobInfo?.jobClassificationCategory}/${ctrl.jobInfo?.subJobClassificationsCategory}",
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
              desc: "\$${ctrl.jobInfo?.rate}/${ctrl.jobInfo?.hours}",
              titleColor: redTextColor,
              onIbuttonClick: () {
                if (ctrl.jobInfo != null) {
                  showDialogOnIButtonClick(context, ctrl.jobInfo!);
                }
              }).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: guarHours,
            desc: ctrl.jobInfo?.guaranteedHour.toString(),
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
            desc: ctrl.jobInfo?.paidByName.toString(),
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: terms,
            desc: ctrl.jobInfo?.term.toString(),
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
            desc: ctrl.jobInfo?.productionTitle,
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
            desc: createCompanyAddress(ctrl),
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

  void showDialogOnIButtonClick(
    BuildContext context,
    GetJobInfoModel jobInfo,
  ) {
    /* num hour = (jobInfo.hours.toString().toLowerCase() ==
            "10 hours".toLowerCase()
        ? 10
        : jobInfo.hours.toString().toLowerCase() == "Hourly".toLowerCase()
            ? 1
            : jobInfo.hours.toString().toLowerCase() == "8 hours".toLowerCase()
                ? 8
                : jobInfo.hours.toString().toLowerCase() ==
                        "12 hours".toLowerCase()
                    ? 12
                    : 0);*/

    num hour = getHour(jobInfo);
    num perHourRate = int.parse(jobInfo.rate.toString()) / hour;

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
            desc: "\$${jobInfo.rate}/$hour",
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
            desc: perHourRate.isNaN ? "-" : perHourRate.toStringAsFixed(2),
          ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: hourlyX15,
            desc: perHourRate.isNaN
                ? "-"
                : (perHourRate * 1.5).toStringAsFixed(2),
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
          detailItem(
            title: Hourly20,
            desc:
                perHourRate.isNaN ? "-" : (perHourRate * 2).toStringAsFixed(2),
          ).paddingOnly(
            top: screenHPadding8.sh(),
            bottom: screenHPadding8.sh(),
          ),
        ],
      ),
    );
  }

  calculateAmount(int amount, String perHowManyHours) {}

  createCompanyAddress(JobInfoController ctrl) {
    return "${ctrl.jobInfo?.companyAddressLine1 ?? ""}"
        "\n${ctrl.jobInfo?.companyAddressLine2 ?? ""}"
        "\n${ctrl.jobInfo?.city ?? ""}, ${ctrl.jobInfo?.state ?? ""} "
        "${ctrl.jobInfo?.zip == 0 ? "" : ctrl.jobInfo?.zip}\n${ctrl.jobInfo?.country ?? ""}";
  }

  num getHour(GetJobInfoModel jobInfo) {
    num hour = (jobInfo.hours.toString().toLowerCase() ==
            "10 hours".toLowerCase()
        ? 10
        : jobInfo.hours.toString().toLowerCase() == "Hourly".toLowerCase()
            ? 1
            : jobInfo.hours.toString().toLowerCase() == "8 hours".toLowerCase()
                ? 8
                : jobInfo.hours.toString().toLowerCase() ==
                        "12 hours".toLowerCase()
                    ? 12
                    : 0);

    if (hour <= 8) {
      return hour;
    }

    if (hour > 8 && hour < 12) {
      num moreHour = hour - 8;
      return 8 + (moreHour * 1.5);
    }

    if (hour >= 12) {
      num moreThan12 = hour - 12;
      num moreThan8 = hour - (moreThan12 + 8);
      return 8 + (moreThan12 * 2) + (moreThan8 * 1.5);
    }
    return hour;
  }
}
