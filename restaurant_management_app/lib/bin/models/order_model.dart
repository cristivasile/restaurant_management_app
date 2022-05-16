import 'package:restaurant_management_app/bin/models/product_model.dart';

class OrderModel {
  late List<ProductModel> products;
  late List<int> quantities;
  late double price;
  late String tableId;

  
  OrderModel(
      {required this.products,
      required this.quantities,
      required this.tableId}) {
    price = 0;

    for (int idx = 0; idx < products.length; idx += 1) {
      price += products[idx].price * quantities[idx];
    }
  }

  OrderModel.fromJson(Map<String, dynamic> dic) {
    tableId = dic['tableId'];
    price = dic['price'];

    products = [];
    for (var product in dic['products']) {
      products.add(ProductModel.fromJson(product));
    }

    quantities = [];
    for (var quantity in dic['quantities']) {
      quantities.add(quantity);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'tableId': tableId,
      'price': price,
      'products': products,
      'quantities': quantities
    };
  }
}
