import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../../constant/space_constant.dart';
import '../../../../widgets/fm_textfield.dart';
import 'notes_controller.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({
    Key? key,
    required this.jobId,
    required this.isExample,
  }) : super(key: key);

  int jobId;
  bool isExample;

  final controller = Get.put(NotesController());
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(
      initState: (initState) {
        controller.getAllNotes(jobId: jobId);
      },
      builder: (ctrl) {
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
                  color: Colors.white,
                ),
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
                            focusNode: FocusNode(),textInputAction: TextInputAction.newline,
                            controller: ctrl.noteController,
                            hintText: "Click anywhere to start taking notes!",
                            maxLines: 18,
                            textInputType: TextInputType.multiline,
                            onchange: (value) {
                              if (_debounce?.isActive ?? false)
                                _debounce!.cancel();
                              _debounce = Timer(
                                const Duration(seconds: 2),
                                () {
                                  controller.editNotes(
                                      jobId: jobId, note: value);
                                },
                              );
                            },
                            enable: !isExample,
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
      },
    );
  }
}
