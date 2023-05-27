import '../../../globle.dart';

class AddJobController extends GetxController{


  bool isExpanded = false;
  onExpansionChange(bool value){
    isExpanded =value;
    update(["CompanyAdddressExpanded"]);
  }
}
