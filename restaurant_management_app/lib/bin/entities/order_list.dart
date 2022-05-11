

import '../models/order_model.dart';
import '../services/order_service.dart';

OrderList? object;

class OrderList{
  late List<OrderModel> _orders;
  OrderList._();

  static Future<void> loadOrderList() async {
    
    if(object == null){
      object = OrderList._();
      object!._orders = await loadOrders();
    }
  }

  static List<OrderModel> getOrderList() {

    object ??= OrderList._();

    return object!._orders;
  }

  static void setOrderList(List<OrderModel> newTables){
    object ??= OrderList._();
    object!._orders = newTables;
  }

  static void addOrder(OrderModel order){
    object ??= OrderList._();
    object!._orders.add(order);
  }

  ///Removes a order with a given name
  static void removeOrderByTableId(String orderTableId){
    object ??= OrderList._();
    object!._orders.removeWhere((element) => element.tableId.toLowerCase() == orderTableId.toLowerCase());
  }

}