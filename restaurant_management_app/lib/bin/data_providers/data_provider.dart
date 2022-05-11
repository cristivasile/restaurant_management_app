import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' as services;
import 'package:restaurant_management_app/bin/models/product_model.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';

// interface for data storage
// dart does not have interfaces so this is a workaround
abstract class DataProvider{
  Future<List<TableModel>> readTables();
  Future<void> writeTables(List<TableModel> tableList);
  Future<List<ProductModel>> readProducts();
  Future<void> writeProducts(List<ProductModel> productList);
}

// reads and writes to a JSON file
class JsonProvider implements DataProvider{
  static const jsonPath = "assets/temp_json/";
  static const tableFile = "tables.json";
  static const productFile = "products.json";

  static const tablePath = jsonPath + tableFile;
  static const productPath = jsonPath + productFile;

  JsonProvider();

  @override
  Future<List<TableModel>> readTables() async {
    final jsondata = await services.rootBundle.loadString(tablePath);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.map((x) => TableModel.fromJson(x)).toList();
  }

  @override
  Future<void> writeTables(List<TableModel> tableList) async {
    await File(tablePath).writeAsString(json.encode(tableList));
  }

  @override
  Future<List<ProductModel>> readProducts() async {
    
    final jsondata = await services.rootBundle.loadString(productPath);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.map((x) => ProductModel.fromJson(x)).toList();
  }

  @override
  Future<void> writeProducts(List<ProductModel> productList) async {
    await File(productPath).writeAsString(json.encode(productList));
  }

}



