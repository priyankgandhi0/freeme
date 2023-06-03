import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../../constant/space_constant.dart';
import '../../../../widgets/fm_textfield.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 506,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
                color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    "Notes Title"
                        .text(weight: FontWeight.w500, fontSize: 20)
                        .paddingOnly(
                          left: screenWPadding16.sw(),
                          top: screenHPadding16.sh(),
                          bottom: screenHPadding16.sh(),
                        ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FmEmptyTextField(
                        hintText: "Click anywhere to start taking notes!",
                        maxLines: 18,
                        textInputType: TextInputType.multiline,
                      ).paddingOnly(
                        left: screenWPadding16.sw(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ).paddingOnly(
            top: 24.sh(),
            left: screenWPadding16.sw(),
            right: screenWPadding16.sw(),
          )
        ],
      ),
    );
  }
}
