import 'dart:convert';

import 'package:delivery_app/core/class/crud.dart';
import 'package:delivery_app/linkapi.dart';
import 'package:http/http.dart' as http;

class LoginData {
  Crud crud = Crud();
  LoginData(this.crud);
  login(String email, String password) async {
    try {
      final response = await crud.postData(AppLink.loginURL, {
        "email": email,
        "password": password,
      }
      ,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}