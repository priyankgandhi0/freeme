import '../../../../api/repositories/job_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../globle.dart';
import '../../../../models/get_job_info_model.dart';
import '../../navigator/main_controller.dart';

class WorkHistoryController extends GetxController {
  bool isExpanded = false;

  void expansionChange(bool value) {
    isExpanded = value;
    update(["ExpandedItem"]);
  }

  @override
  void onInit() {
    getAllJob();
    super.onInit();
  }

  startLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().startLoading();
    });
  }

  stopLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().stopLoading();
    });
    update();
  }

  List<GetJobInfoModel> allJobList = [];

  Future getAllJob() async {
    startLoading();
    ResponseItem response = await JobRepo.getAllJob();
    if (response.status) {
      allJobList.clear();
      allJobList.addAll(getAllJobFromJson(response.data));
      update();
      stopLoading();
    } else {
      stopLoading();
    }
  }



}
