import 'package:restaurant_management_app/bin/models/order_model.dart';

import '../../main.dart';
import '../entities/order_list.dart';

/// Loads a list of orders, saves it to TableList and returns it
///
Future<List<OrderModel>> loadOrders() async {
  List<OrderModel> orders = await data.readOrders();
  return orders;
}

///Saves orders to disk
///
void saveOrders() {
  List<OrderModel> toSave = OrderList.getOrderList();
  data.writeOrders(toSave); // use global data service to store tables
}