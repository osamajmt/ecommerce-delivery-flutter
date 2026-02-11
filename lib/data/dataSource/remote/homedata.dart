import 'dart:convert';

import 'package:delivery_app/core/class/crud.dart';
import 'package:delivery_app/linkapi.dart';
import 'package:http/http.dart' as http;

class HomeData {
  Crud crud = Crud();
  HomeData(this.crud);
  getSettings() async {
    try {
      final response = await crud.getData(AppLink.settings, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
}
