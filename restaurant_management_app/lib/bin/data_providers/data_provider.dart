import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' as services;
import 'package:restaurant_management_app/bin/models/table_model.dart';

// interface for data storage
// dart does not have interfaces so this is a workaround
abstract class DataProvider{
  Future<List<TableModel>> readTables();
  Future<void> writeTables(List<TableModel> tableList);
}

// reads and writes to a JSON file
class JsonProvider implements DataProvider{
  static const jsonFile = "assets/temp_json/tables.json";
  JsonProvider();
  @override
  Future<List<TableModel>> readTables() async {
    final jsondata = await services.rootBundle.loadString(jsonFile);
    final data = json.decode(jsondata) as List<dynamic>;
    return data.map((x) => TableModel.fromJson(x)).toList();
  }

  @override
  Future<void> writeTables(List<TableModel> tableList) async {
    await File(jsonFile).writeAsString(json.encode(tableList));
  }

}



