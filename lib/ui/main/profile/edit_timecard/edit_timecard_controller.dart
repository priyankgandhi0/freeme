import 'package:flutter/material.dart';

import '../../../../globle.dart';
import '../../../widgets/dropdown.dart';

class EditTimeCardController extends GetxController{

  TextEditingController firstNameController = TextEditingController(text:"Jane");
  TextEditingController lastNameController = TextEditingController(text: "Doe");
  TextEditingController socialSecurityController = TextEditingController(text:"xxx-xx-");



  List<MenuItem> unionNonUnionList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Yes", isSelected: false),
    MenuItem(text: "No", isSelected: false),
  ];
}