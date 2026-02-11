
import 'package:delivery_app/view/screen/orders/available_screen.dart';
import 'package:delivery_app/view/screen/notifications_screen.dart';
import 'package:delivery_app/view/screen/orders/current_screen.dart';
import 'package:delivery_app/view/screen/settings_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  changePage(int currentPage);
}

class HomeControllerImp extends HomeController {
  int currentPage = 0;
  List<Widget> pages = [
    const AvailableOrdersScreen(),
    const CurrentOrdersScreen(),
    const NotificationsScreen(),
    const Settings(),
  ];
  @override
  changePage(int i) {
    currentPage = i;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
