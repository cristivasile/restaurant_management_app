import 'package:restaurant_management_app/bin/models/product_model.dart';

class OrderModel {
  late List<ProductModel> products;
  late Map quantities;
  late double price;
  late String tableId;

  // quantities is a map of (product:quantity_ordered)
  OrderModel({required this.products, required this.quantities, required this.tableId}) {
    price = 0;
    for (var product in products) {
      price += product.price * quantities[product];
    }
  } 
}
