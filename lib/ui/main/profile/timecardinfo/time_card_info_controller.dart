import '../../../../api/repositories/time_card_info_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../globle.dart';
import '../../../../models/time_card_info_model.dart';
import '../../navigator/main_controller.dart';

class TimeCardInfoController extends GetxController{

  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  TimeCardInfoModel? model;
  Future<void> getTimeCardInfo() async {
    startLoading();
    ResponseItem response = await TimeCardInfoRepo.getTimeCardInfo( );
    if (response.status) {
      model = TimeCardInfoModel.fromJson(response.data);
      update();
      stopLoading();
    } else {
      stopLoading();
    }
  }

}