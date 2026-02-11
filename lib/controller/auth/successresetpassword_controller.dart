import 'package:delivery_app/data/dataSource/static/app_routes.dart';
import 'package:get/get.dart';

abstract class successResetPasswordController extends GetxController {

  goToLogin();
}

class successResetPasswordControllerImp extends successResetPasswordController {
  @override
 
  @override
  goToLogin() {
    Future.microtask(() => Get.offAllNamed(appRoute.login));
  }


  @override
  void dispose() {
    super.dispose();
  }
}
