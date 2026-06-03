import 'package:base_module/base_module.dart';

class BottomNavBarProvider extends BaseProvider {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}