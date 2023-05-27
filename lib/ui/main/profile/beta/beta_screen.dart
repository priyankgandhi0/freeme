import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../globle.dart';
import '../../../widgets/fm_appbar.dart';

class BetaScreen extends StatelessWidget {
  const BetaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(
          freeMeBeta,
          onBackClick: () {

          },
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  color: Colors.white),
              child: QrImageView(
                data: 'Free Me App ',
                version: QrVersions.auto,
              ).paddingOnly(
                left: 30.sw(),
                right: 30.sw(),
                top: 30.sh(),
                bottom: 30.sh(),
              ),
            )
                .paddingOnly(
                  top: 24.sh(),
                  left: 50.sw(),
                  right: 50.sw(),
                )
                .center,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      FmButton(
                        ontap: () {
                          //Get.toNamed(Routes.demoScreen);
                        },
                        type: ButtonType.rounded,
                        assetPath: Assets.iconsShare,
                      ),
                      "Share".text().paddingOnly(
                            top: 6.sh(),
                          )
                    ],
                  ),
                  Column(
                    children: [
                      FmButton(
                        ontap: () {
                         // Get.toNamed(Routes.demoScreen);
                        },
                        type: ButtonType.rounded,
                        assetPath: Assets.iconsLink,
                      ),
                      "Copy Link".text().paddingOnly(
                            top: 6.sh(),
                          )
                    ],
                  )
                ],
              ).paddingOnly(
                top: screenHPadding16.sh(),
                bottom: screenHPadding16.sh(),
              ),
            ).paddingOnly(
              left: 50,
              right: 50,
              top: 24,
            )
          ],
        ),
      ),
      onWillPop: () async {

        return false;
      },
    );
  }
}
