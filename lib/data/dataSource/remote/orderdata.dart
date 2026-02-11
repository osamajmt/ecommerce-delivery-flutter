
import 'package:delivery_app/core/class/crud.dart';
import 'package:delivery_app/linkapi.dart';
class OrderData {
  Crud crud = Crud();
  OrderData(this.crud);
  getAvailableOrders() async {
    try {
      final response = await crud.getData(AppLink.availableOrders,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
    acceptOrder(int orderId) async {
    try {
      final response = await crud.postData("${AppLink.acceptOrder}/$orderId",
      {
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getCurrentOrders() async {
    try {
      final response = await crud.postData(AppLink.currentOrders,
      {
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
   completeOrder(int orderId) async {
    try {
      final response = await crud.postData("${AppLink.completeOrder}/$orderId",
      {
        "order_id":orderId,
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
   startOrder(int orderId) async {
    try {
      final response = await crud.postData("${AppLink.startOrder}/$orderId",
      {
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getOrderDetails(int orderId) async {
    try {
      final response = await crud.getData("${AppLink.orderDetails}/$orderId",
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
 

}