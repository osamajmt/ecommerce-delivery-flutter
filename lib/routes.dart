
import 'package:delivery_app/core/middleware/mymiddleware.dart';
import 'package:delivery_app/data/dataSource/static/app_routes.dart';
import 'package:delivery_app/view/screen/driver_profile.dart';
import 'package:delivery_app/view/screen/home.dart';
import 'package:delivery_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:delivery_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:delivery_app/view/screen/auth/login.dart';
import 'package:delivery_app/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:delivery_app/view/screen/auth/forgetpassword/verifyemail.dart';
import 'package:delivery_app/view/screen/language_screen.dart';
import 'package:delivery_app/view/screen/onboarding_screen.dart';
import 'package:delivery_app/view/screen/orders/available_screen.dart';
import 'package:delivery_app/view/screen/orders/current_screen.dart';
import 'package:delivery_app/view/screen/orders/details.dart';
import 'package:delivery_app/view/screen/system_info.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: "/",
    page: () => const Language(),
    middlewares: [Mymiddleware()],
  ),
 
  GetPage(name: appRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(name: appRoute.login, page: () => const Login()),
  GetPage(name: appRoute.onboarding, page: () => const OnBoarding()),
  GetPage(name: appRoute.forgetpassword, page: () => const ForgetPassword()),
  GetPage(name: appRoute.verifyemail, page: () => const VerifyEmail()),
  GetPage(name: appRoute.resetpassword, page: () => const ResetPassword()),
  GetPage(
    name: appRoute.successresetpassword,
    page: () => const SuccessResetPassword(),
  ),
  GetPage(name: appRoute.currentOrders, page: () => const CurrentOrdersScreen()),
  GetPage(name: appRoute.availableOrders, page: () => const AvailableOrdersScreen()),
  GetPage(name: appRoute.orderDetails, page: () => const OrderDetailsScreen()),


  GetPage(name: appRoute.driverProfile, page: () => const DriverProfile()),
  GetPage(name: appRoute.systemInfo, page: () => const SystemInfo()),
];

