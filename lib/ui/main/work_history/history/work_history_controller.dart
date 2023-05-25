import '../../../../globle.dart';

class WorkHistoryController extends GetxController {

  bool isExpanded = false;
  void expansionChange(bool value) {
    isExpanded = value;
    update(["ExpandedItem"]);
  }
}
