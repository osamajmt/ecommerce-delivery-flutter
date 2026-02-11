import 'dart:ui';

import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/data/dataSource/static/app_routes.dart';
import 'package:delivery_app/data/dataSource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

abstract class OnBoardingController extends GetxController {
  next();
  onPageChanged(int index);
  Services myServices = Get.find();
}

class OnBoardingControllerImp extends OnBoardingController {
  late PageController pageController;
  int currentPage = 0;
  @override
  next() {
    currentPage++;
    if (currentPage == onBoardingList.length) {
      myServices.sharedPreferences.setString("step", "1");
      Get.offAllNamed(appRoute.login);
    } else {
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
