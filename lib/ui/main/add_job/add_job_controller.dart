import '../../../globle.dart';

class AddJobController extends GetxController {
  bool isExpanded = false;

  onExpansionChange(bool value) {
    isExpanded = value;
    update(["CompanyAdddressExpanded"]);
  }

  var nonTaxedItem = [
    NonTaxedItem("Monitor","\$250 / Day"),
  ];
}

class NonTaxedItem {
  String name;
  String value;

  NonTaxedItem(this.name, this.value);
}
