import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' as services;
import 'package:restaurant_management_app/bin/models/product_model.dart';
import 'package:restaurant_management_app/bin/models/reservation_model.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';

import '../models/order_model.dart';

// interface for data storage
// dart does not have interfaces so this is a workaround
abstract class DataProvider {
  Future<List<TableModel>> readTables();
  Future<void> writeTables(List<TableModel> tableList);
  Future<List<ProductModel>> readProducts();
  Future<void> writeProducts(List<ProductModel> productList);
  Future<List<OrderModel>> readOrders();
  Future<void> writeOrders(List<OrderModel> orderList);
  Future<List<ReservationModel>> readReservations();
  Future<void> writeReservations(List<ReservationModel> productList);
  Future<List<int>> readCapacities();
  Future<void> writeCapacities(List<int> capacities);
}

// reads and writes to a JSON file
class JsonProvider implements DataProvider {
  static const jsonPath = "assets/temp_json/";
  static const tableFile = "tables.json";
  static const productFile = "products.json";
  static const orderFile = "orders.json";
  static const reservationFile = "reservations.json";
  static const capacitiesFile = "capacities.json";

  static const tablePath = jsonPath + tableFile;
  static const productPath = jsonPath + productFile;
  static const orderPath = jsonPath + orderFile;
  static const reservationPath = jsonPath + reservationFile;
  static const capacitiesPath = jsonPath + capacitiesFile;

  JsonProvider();

  @override
  Future<List<TableModel>> readTables() async {
    final jsondata = await services.rootBundle.loadString(tablePath);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.map((x) => TableModel.fromJson(x)).toList();
  }

  @override
  Future<void> writeTables(List<TableModel> tableList) async {
    String tableString = "[${tableList.join(",\n")}]";
    await File(tablePath).writeAsString(tableString);
  }

  @override
  Future<List<ProductModel>> readProducts() async {
    final jsondata = await services.rootBundle.loadString(productPath);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.map((x) => ProductModel.fromJson(x)).toList();
  }

  @override
  Future<void> writeProducts(List<ProductModel> productList) async {
    String productString = "[${productList.join(",\n")}]";
    await File(productPath).writeAsString(productString);
  }
  
  @override
  Future<List<OrderModel>> readOrders() async {
    final jsondata = await services.rootBundle.loadString(orderPath);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.map((x) => OrderModel.fromJson(x)).toList();
  }

  @override
  Future<void> writeOrders(List<OrderModel> orderList) async {
    await File(orderPath).writeAsString(json.encode(orderList));
  }

  @override
  Future<List<ReservationModel>> readReservations() async {
    final jsondata = await services.rootBundle.loadString(reservationPath);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.map((x) => ReservationModel.fromJson(x)).toList();
  }

  @override
  Future<void> writeReservations(List<ReservationModel> reservationList) async {
    await File(reservationPath).writeAsString(json.encode(reservationList));
  }

  @override
  Future<List<int>> readCapacities() async{
    final jsondata = await services.rootBundle.loadString(capacitiesPath);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.cast<int>();
  }

  @override
  Future<void> writeCapacities(List<int> capacities) async{
    await File(capacitiesPath).writeAsString(json.encode(capacities));
  }
}