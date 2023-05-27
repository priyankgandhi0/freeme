import 'package:flutter/material.dart';
import '../../../../globle.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/profile_image.dart';
import 'myprofile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({Key? key}) : super(key: key);

  final controller = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(
          myProfile,
          onBackClick: () {
            Navigator.pop(context);
          },
          onTrailingClick: () {
            Navigator.pushNamed(context, Routes.editProfileScreen);

          },
        ),
        body: Column(
          children: [
            Row(
              children: [
                profileImage(
                  103,
                  103,
                  horizontalPadding: 36,
                  verticlePadding: 34,
                ).paddingOnly(
                  top: 24.sh(),
                  left: screenWPadding16.sw(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Erica Chan"
                        .text(
                          fontSize: 20,
                          weight: FontWeight.w500,
                        )
                        .paddingOnly(top: 16),
                    "IATSE Local 600"
                        .text(
                          fontSize: 16,
                        )
                        .paddingOnly(top: 8),
                    "1st Assistant Camera, Director"
                        .text(
                          fontSize: 16,
                          fontColor: greyTextColor,
                        )
                        .paddingOnly(top: 8),
                  ],
                ).paddingOnly(
                  left: 24.sw(),
                )
              ],
            ),
            contentCard(
              "Mobile",
              "1-213-000-0000",
              textColor: blueTextColor
            ).paddingOnly(top: 32),
            contentCard(
              "E-mail",
              "work_email@gmail.com",
                textColor: blueTextColor
            ).paddingOnly(top: 16),
            contentCard(
              "Website",
              "www.my_website.com",
                textColor: blueTextColor
            ).paddingOnly(top: 16),
            contentCard(
              "About Me",
              "Likes to play golf, pool, games",
            ).paddingOnly(top: 16),
          ],
        ),
      ),
      onWillPop: () async {

        return false;
      },
    );
  }

  Widget contentCard(
    String title,
    String value,{
      Color? textColor = Colors.black
  }
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.text(
                weight: FontWeight.w500,
                fontSize: 16,
              ),
              value
                  .text(
                    fontColor: textColor,
                    fontSize: 16,
                  )
                  .paddingOnly(
                    top: screenHPadding8.sh(),
                  )
            ],
          )
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        bottom: screenHPadding16.sh(),
        left: screenWPadding16.sw(),
      ),
    ).paddingOnly(
      left: 16.sw(),
      right: 16.sw(),
    );
  }
}
