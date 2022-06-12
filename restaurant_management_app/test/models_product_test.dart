import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_management_app/bin/models/product_model.dart';

void main() {
  var productModel =
      ProductModel(name: "Whiskey", price: 235.0, category: "Spirits");

  var productJson = {
    "name": "Whiskey",
    "price": 235.0,
    "category": "Spirits"
  };

  test('toJson: valid product to Json', () {
    var result = productModel.toJson();
    expect(result, productJson);
  });
}