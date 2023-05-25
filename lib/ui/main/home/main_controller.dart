import '../../../../globle.dart';

class HomeController extends GetxController{
  int selectedIndex = 0;

  void updateSelectedIndex(int index) {
     selectedIndex = index;
     update();
  }
}