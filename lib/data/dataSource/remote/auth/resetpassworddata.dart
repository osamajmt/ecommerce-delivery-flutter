import 'dart:convert';

import 'package:delivery_app/core/class/crud.dart';
import 'package:delivery_app/linkapi.dart';
import 'package:http/http.dart' as http;

class ResetPasswordData {
  Crud crud = Crud();
  ResetPasswordData(this.crud);
  resetPassword(String? email,String password) async {
    try {
      final response = await crud.patchData(AppLink.resetPassword, {
        "email":email,
        "password": password,
      },{});
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}

