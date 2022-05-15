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
}

// reads and writes to a JSON file
class JsonProvider implements DataProvider {
  static const jsonPath = "assets/temp_json/";
  static const tableFile = "tables.json";
  static const productFile = "products.json";
  static const orderFile = "orders.json";
  static const reservationFile = "reservations.json";

  static const tablePath = jsonPath + tableFile;
  static const productPath = jsonPath + productFile;
  static const orderPath = jsonPath + orderFile;
  static const reservationPath = jsonPath + reservationFile;

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
}
