
import 'package:restaurant_management_app/bin/models/product_model.dart';

import '../services/product_service.dart';

ProductList? object;

class ProductList{
  late List<ProductModel> _products;
  ProductList._();

  static Future<void> loadProductList() async {
    
    if(object == null){
      object = ProductList._();
      object!._products = await loadProducts();
    }
  }

  static List<ProductModel> getProductList() {

    object ??= ProductList._();

    return object!._products;
  }

  static void setProductList(List<ProductModel> newTables){
    object ??= ProductList._();
    object!._products = newTables;
  }

  static void addProduct(ProductModel product){
    object ??= ProductList._();
    object!._products.add(product);
  }

  ///Removes a product with a given name
  static void removeProductByName(String productName){
    object ??= ProductList._();
    object!._products.removeWhere((element) => element.name.toLowerCase() == productName.toLowerCase());
  }

}