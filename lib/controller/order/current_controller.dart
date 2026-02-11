import 'package:delivery_app/core/class/statusRequest.dart';
import 'package:delivery_app/core/function/handlingdata.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/data/dataSource/remote/homedata.dart';
import 'package:delivery_app/data/dataSource/remote/orderdata.dart';
import 'package:get/get.dart';

abstract class CurrentOrdersController extends GetxController {
  Services myServices = Get.find();
  OrderData orderData = OrderData(Get.find());
  String? userName;
  int? userId;
  StatusRequest? statusRequest;
  List settings = [];
  String? lang;
  List currentOrders = [];
  initialData();
  getSettings();
  getCurrentOrders();
}

class CurrentOrdersControllerImp extends CurrentOrdersController {
  HomeData homeData = HomeData(Get.find());

  getUserId() async {
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
    print(userId);
  }

  @override
  initialData() {
    lang = myServices.sharedPreferences.getString("lang");
    userName = myServices.sharedPreferences.getString('user_name');
    getCurrentOrders();
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

  @override
  getCurrentOrders() async {
    currentOrders.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await orderData.getCurrentOrders();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          currentOrders.addAll(response['orders']);
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

  completeOrder(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.completeOrder(orderId);
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

  startOrder(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.startOrder(orderId);
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
    currentOrders.clear();
  }

  refreshPage() {
    print("=====================refresh");
    resetPageVars();
    getCurrentOrders();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getUserId(); 
    initialData();     
  }

  
}
