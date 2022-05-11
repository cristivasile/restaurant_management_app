import 'package:restaurant_management_app/bin/models/product_model.dart';

import '../../main.dart';
import '../entities/product_list.dart';

/// Loads a list of tables, saves it to TableList and returns it
///
Future<List<ProductModel>> loadProducts() async {
  List<ProductModel> products = await data.readProducts();
  return products;
}

///Saves tables to disk
///
void saveProducts() {
  List<ProductModel> toSave = ProductList.getProductList();
  data.writeProducts(toSave); // use global data service to store tables
}