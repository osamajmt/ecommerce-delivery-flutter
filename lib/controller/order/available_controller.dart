import 'package:delivery_app/core/class/statusRequest.dart';
import 'package:delivery_app/core/function/handlingdata.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/data/dataSource/remote/homedata.dart';
import 'package:delivery_app/data/dataSource/remote/orderdata.dart';
import 'package:delivery_app/data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class AvailableOrdersController extends GetxController {
  Services myServices = Get.find();
  OrderData orderData = OrderData(Get.find());
  String? userName;
  int? userId;
  StatusRequest? statusRequest;
  List settings = [];
  String? lang;
  List availableOrders = [];
  initialData();
  getSettings();
  acceptOrder(int orderId);
}

class AvailableOrdersControllerImp extends AvailableOrdersController {
  HomeData homeData = HomeData(Get.find());
  getUserId() async {
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }

  @override
  initialData() async {
    lang = myServices.sharedPreferences.getString("lang");
    userName = myServices.sharedPreferences.getString('user_name');
    getAvailableOrders();
  }

  String printOrderType(int val) {
    if (val == 0) {
      return "By hand";
    } else {
      return "Delivery";
    }
  }

  String prtintPaymentMethod(int val) {
    if (val == 0) {
      return "Cash";
    } else {
      return "Payment card";
    }
  }

  String printOrderStatus(int val) {
    if (val == 0) {
      return "Pending";
    } else {
      return "Approved";
    }
  }

  @override
  getSettings() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await homeData.getSettings();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          settings.addAll(response['settings']);
          myServices.sharedPreferences.setString(
            "deliveryTime",
            settings[0]['delivery_time'],
          );
        } else {
          Get.defaultDialog(
            title: 'Warning',
            middleText: " Email or Password is not valid",
          );
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = response;
        if (statusRequest == StatusRequest.serverFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "Server error. Please try again later.",
          );
        } else if (statusRequest == StatusRequest.offlineFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "No internet connection.",
          );
        }
      }
      update();
    } catch (e) {
      print("Unexpected error: $e");
      statusRequest = StatusRequest.serverException;
      Get.defaultDialog(
        title: 'Error',
        middleText: "An unexpected error occurred",
      );
    }
  }

  getAvailableOrders() async {
    availableOrders.clear();
    try {
      statusRequest = StatusRequest.loading;
      print(1);
      var response = await orderData.getAvailableOrders();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          availableOrders.addAll(response['orders']);
        } else {
          Get.defaultDialog(title: 'Warning', middleText: " invalid");
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = response;
        if (statusRequest == StatusRequest.serverFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "Server error. Please try again later.",
          );
        } else if (statusRequest == StatusRequest.offlineFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "No internet connection.",
          );
        }
      }
      update();
    } catch (e) {
      print("Unexpected error: $e");
      statusRequest = StatusRequest.serverException;
      Get.defaultDialog(
        title: 'Error',
        middleText: "An unexpected error occurred",
      );
    }
  }

  @override
  acceptOrder(int orderId) async {
   print("DEBUG userId = $userId");
  print("DEBUG orderId = $orderId");

  if (userId == null) {
    Get.snackbar("Error", "UserId is null");
    return;
  }
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.acceptOrder(orderId);
    print("============================== $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
      } else {
        Get.defaultDialog(title: 'Warning', middleText: "invalid");
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = response;
      if (statusRequest == StatusRequest.serverFailure) {
        Get.defaultDialog(
          title: 'Error',
          middleText: "Server error. Please try again later.",
        );
      } else if (statusRequest == StatusRequest.offlineFailure) {
        Get.defaultDialog(
          title: 'Error',
          middleText: "No internet connection.",
        );
      }
    }
    update();
  }

  resetPageVars() {
    print("=====================reset");
    availableOrders.clear();
  }

  refreshPage() {
    print("=====================refresh");
    resetPageVars();
    getAvailableOrders();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getUserId();   
    initialData();      
  }

}
