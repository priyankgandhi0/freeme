import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:freeme/models/get_job_info_model.dart';
import 'package:intl/intl.dart';

import '../../../../globle.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/fm_dialog.dart';
import '../../../widgets/fm_expanded_view.dart';
import 'work_history_controller.dart';

class WorkHistoryScreen extends StatelessWidget {
  WorkHistoryScreen({Key? key}) : super(key: key);

  final controller = Get.put(WorkHistoryController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(
          workHistory,
        ),
        body: SingleChildScrollView(
          /*   physics: BouncingScrollPhysics(),*/
          child: GetBuilder<WorkHistoryController>(initState: (initState) {
            // controller.getAllJob();
          }, builder: (ctrl) {
            return Column(
              children: [
                addNewJob(context),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ctrl.allJobList.length,
                  itemBuilder: (context, index) {
                    var job = ctrl.allJobList[index];
                    return fMExpandedView(
                      title: job.description,
                      description: createDescription(job.days),
                      onTap: job.days != null &&
                              job.days!.isNotEmpty &&
                              job.days!.length == 1
                          ? () {
                              Navigator.pushNamed(
                                context,
                                Routes.workHistoryDetailScreen,
                                arguments: {
                                  "job_id": job.days![0].jobId,
                                  "day_id": job.days![0].dayId,
                                  "date": job.days![0].date,
                                  "title": job.description,
                                },
                              );
                            }
                          : null,
                      onChildTap: (index) {
                        Navigator.pushNamed(
                          context,
                          Routes.workHistoryDetailScreen,
                          arguments: {
                            "job_id": job.days![index].jobId,
                            "day_id": job.days![index].dayId,
                            "date": job.days![index].date,
                            "title": job.description,
                          },
                        );
                      },
                      childList: [
                        if (job.days != null &&
                            job.days!.isNotEmpty &&
                            job.days!.length != 1)
                          ...(job.days ?? [])
                              .map((e) =>
                                  "${chageFormat(e.date.toString())} - ${job.description}")
                              .toList()
                      ],
                    ).paddingOnly(
                      top: 24.sh(),
                    );
                  },
                ),

                /* fMExpandedView(
                  title: "Commercial With Adam",
                  description: "07/23/22",
                ).onTap(() {}).paddingOnly(
                      top: 24.sh(),
                    ),
                fMExpandedView(
                  title: "Soulmates",
                  description: "7/12/22 - 7/23/22",
                  childList: const [
                    "07/23/22 - Soulmates",
                    "07/16/22 - Soulmates",
                    "07/12/22 - Soulmates",
                  ],
                ).paddingOnly(
                  top: screenHPadding16.sh(),
                ),
                fMExpandedView(
                  title: "John JLO",
                  description: "07/02/22",
                ).paddingOnly(
                  top: screenHPadding16.sh(),
                ),
                fMExpandedView(
                  title: "Girlswirl",
                  description: "06/11/22",
                ).paddingOnly(
                  top: screenHPadding16.sh(),
                ),
                fMExpandedView(
                  title: "Culprit",
                  description: "05/21/22",
                ).paddingOnly(
                  top: screenHPadding16.sh(),
                ),
*/
                //expandableItem(),
              ],
            ).safeArea;
          }),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget addNewJob(BuildContext context) {
    return Container(
      child: DottedBorder(
        color: darkGreenColor,
        strokeWidth: 1,
        dashPattern: const [
          6,
          3,
        ],
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: SizedBox(
          width: Get.width,
          child: "Add New Job"
              .text(
                  fontSize: 18,
                  fontColor: darkGreenColor,
                  weight: FontWeight.w500)
              .center
              .paddingOnly(
                top: 16.sh(),
                bottom: 16.sh(),
              ),
        ),
      ).onTap(() {
        showAddJobDialog(context);
      }).paddingOnly(left: 16.sw(), right: 16.sw(), top: 24.sh(), bottom: 10),
    );
  }

  showAddJobDialog(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: 48,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addJob
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
                  .paddingOnly(
                top: 22.sh(),
                right: 22.sw(),
                left: 22.sw(),
                bottom: 22.sw(),
              )
                  .onTap(
                () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ).positioned(right: 0)
            ],
          ),
          Container(
            width: Get.width,
            height: 1,
            color: bottomLineGreyColor,
          ),
          FmButton(
            ontap: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushNamed(context, Routes.addJobScreen);
            },
            name: manualEntry,
            type: ButtonType.greenCircular,
          ).paddingOnly(
            left: 24.sw(),
            right: 24.sw(),
            top: 24.sw(),
          ),
          FmButton(
            ontap: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushNamed(context, Routes.quickEntryScreen);
            },
            name: quickEntry,
            type: ButtonType.greenCircular,
          ).paddingOnly(
            left: 24.sw(),
            right: 24.sw(),
            top: screenHPadding16.sh(),
            bottom: 24.sw(),
          )
        ],
      ),
    );
  }

  chageFormat(String date) {
    DateTime now = DateTime.parse(date);
    String formattedDate = DateFormat('MM/dd/yy').format(now);
    return formattedDate;
  }

  String createDescription(List<Days>? days) {
    if (days != null && days.isNotEmpty) {
      if (days.length == 1) {
        return "${chageFormat(days.first.date.toString())}";
      } else {
        return "${chageFormat(days.first.date.toString())} - ${chageFormat(days.last.date.toString())}";
      }
    } else {
      return "";
    }
  }
}
