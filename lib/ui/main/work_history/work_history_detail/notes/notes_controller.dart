import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../api/repositories/job_repo.dart';
import '../../../../../api/response_item.dart';
import '../../../navigator/main_controller.dart';

class NotesController extends GetxController {
  startLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().startLoading();
    });
  }

  stopLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().stopLoading();
    });
  }

  TextEditingController noteController = TextEditingController();

  Future<void> getAllNotes({
    required int jobId,
  }) async {
     // startLoading();
    try{
      noteController.clear();
      ResponseItem response = await JobRepo.getNotes(jobId: jobId);
      if (response.status) {
        noteController.text = response.data["notes"];
        noteController.selection = TextSelection.fromPosition(
          TextPosition(offset: noteController.text.length),
        );
        // stopLoading();
      } else {
        //stopLoading();
      }
    } catch(e){
       //stopLoading();
    }
  }

  Future<void> editNotes({
    required int jobId,
    required String note,
  }) async {
    //startLoading();
    ResponseItem response = await JobRepo.editNotes(
      jobId: jobId,
      notes: note,
    );
    if (response.status) {
      //getAllNotes(jobId: jobId);
      // stopLoading();
    } else {
      // stopLoading();
    }
  }

  void clearController() {
    noteController.clear();
  }
}
