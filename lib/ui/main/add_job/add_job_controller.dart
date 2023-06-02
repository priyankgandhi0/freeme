import '../../../globle.dart';
import '../../widgets/dropdown.dart';

class AddJobController extends GetxController {
  bool isExpanded = false;

  onExpansionChange(bool value) {
    isExpanded = value;
    update(["CompanyAdddressExpanded"]);
  }

  var nonTaxedItem = [
    NonTaxedItem("Monitor", "\$250 / Day"),
  ];

  List<MenuItem> firstItems = [
    MenuItem(text: "None", isSelected: true),
    MenuItem(text: "05 Hours", isSelected: false),
    MenuItem(text: "06 Hours", isSelected: false),
    MenuItem(text: "07 Hours", isSelected: false),
    MenuItem(text: "08 Hours", isSelected: false),
    MenuItem(text: "09 Hours", isSelected: false),
    MenuItem(text: "10 Hours", isSelected: false),
    MenuItem(text: "11 Hours", isSelected: false),
    MenuItem(text: "12 Hours", isSelected: false),
    MenuItem(text: "13 Hours", isSelected: false),
    MenuItem(text: "14 Hours", isSelected: false),
    MenuItem(text: "15 Hours", isSelected: false),
    MenuItem(text: "16 Hours", isSelected: false),
  ];

  List<MenuItem> perHoursList = [
    MenuItem(text: "10 hours", isSelected: true),
    MenuItem(text: "Hourly", isSelected: false),
    MenuItem(text: "8 hours", isSelected: false),
    MenuItem(text: "12 hours", isSelected: false),
  ];

  List<MenuItem> guaranteedHoursList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "8 hours", isSelected: false),
    MenuItem(text: "10 hours", isSelected: false),
    MenuItem(text: "12 hours", isSelected: false),
  ];
  List<MenuItem> w21099List = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "W2", isSelected: false),
    MenuItem(text: "1099", isSelected: false),
  ];

  List<MenuItem> paidByList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "ABS Payroll", isSelected: false),
    MenuItem(text: "Cast & Crew", isSelected: false),
    MenuItem(text: "Entertainment Partners", isSelected: false),
    MenuItem(text: "Extreme reach", isSelected: false),
    MenuItem(text: "Greenslate", isSelected: false),
    MenuItem(text: "Media services", isSelected: false),
    MenuItem(text: "NPI Entertainment Payroll", isSelected: false),
    MenuItem(text: "Payday", isSelected: false),
    MenuItem(text: "The Jacobson Group", isSelected: false),
    MenuItem(text: "The TEAM Services", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];

  List<MenuItem> termsList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Net 15", isSelected: false),
    MenuItem(text: "Net 30", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];

  List<MenuItem> typeList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Commercial", isSelected: false),
    MenuItem(text: "Episodic Scripted", isSelected: false),
    MenuItem(text: "Music Video", isSelected: false),
    MenuItem(text: "Episodic Unscripted", isSelected: false),
    MenuItem(text: "Short Film", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];

  List<MenuItem> unionNonUnionList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Yes", isSelected: false),
    MenuItem(text: "No", isSelected: false),
  ];
}

class NonTaxedItem {
  String name;
  String value;

  NonTaxedItem(this.name, this.value);
}
