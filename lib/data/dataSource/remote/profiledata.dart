import 'dart:convert';
import 'package:delivery_app/core/class/crud.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/linkapi.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class ProfileData {
  Crud crud = Crud();
  ProfileData(this.crud);
 updateImage(String id,String imagePath) async {
    try {
      Services myServices = Get.find();
      String? token = await myServices.secureStorage.read(key: "token");

      var request =
          http.MultipartRequest("POST", Uri.parse(AppLink.updateUserImage));
      request.fields['userId'] = id;

        request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      

     if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imagePath));
      }
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      return jsonDecode(responseBody.body);
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
}