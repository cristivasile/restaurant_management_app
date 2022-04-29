// ignore: file_names
import 'package:flutter/material.dart';
import 'package:restaurant_management_app/main.dart';
import '../models/table_model.dart' as table_model;
import '../widgets/table_widget.dart';

/// Returns a list of MovableTable from a list of tables
///
/// @param tables: a list of tables
/// @param constraints: a MovableTable needs the BoxConstraints from where it is created
List<MovableTable> getWidgetsFromTables(
    List<table_model.TableModel> tables, BoxConstraints constraints) {
  List<MovableTable> result = [];

  for (table_model.TableModel table in tables) {
    result.add(MovableTable(
      constraints: constraints,
      tableSize: table.tableSize,
      position: Offset(table.xOffset, table.yOffset),
      id: table.id,
    ));
  }

  return result;
}

/// Returns a list of Table from a list of MovableTable widgets
///
///@param tableWidgets: list of widgets
List<table_model.TableModel> getTablesFromTableWidgets(
    List<MovableTable> tableWidgets) {
  List<table_model.TableModel> tables = [];

  for (MovableTable widget in tableWidgets) {
    tables.add(table_model.TableModel(
        id: widget.id,
        xOffset: widget.position.dx,
        yOffset: widget.position.dy,
        tableSize: widget.tableSize));
  }

  return tables;
}

/// Loads a list of tables and returns it
///
Future<List<table_model.TableModel>> loadTables() async {
  List<table_model.TableModel> result = await data.readTables();
  return result;
}

///Saves tables to disk
///
///@param tables: MovableTable widgets
void saveTables(List<MovableTable> tables) {
  List<table_model.TableModel> toSave = getTablesFromTableWidgets(tables);
  data.writeTables(toSave); // use global data service to store tables
}

/// Generates unique ID for a table. Must receive either a list of tables or list of tableWidgets.
/// 
/// @param(optional) tables = a list of tables
/// @param(optional)
String generateTableId({List<table_model.TableModel>? tables, List<MovableTable>? tableWidgets, required int tableSize}){

  /// Returns corresponding table letter, given a size
  ///
  String getTableLetterFromSize(){
    switch (tableSize) {
    case 2:
      return 'A';
    case 3:
      return 'B';
    case 4:
      return 'C';
    case 6:
      return 'D';
    case 8:
      return 'E';
  }
    throw Exception("Invalid table size!");
  }

  if (tables != null && tableWidgets != null) {
    throw Exception("Invalid parameters provided!");
  }

  var filteredTableIds = [];

  if (tables != null){
    filteredTableIds = tables.where((x) => x.tableSize == tableSize).map((x) {return x.id;}).toList(); // get tables of same size and select only ids
  }
  else if (tableWidgets != null){
    filteredTableIds = tableWidgets.where((x) => x.tableSize == tableSize).map((x) {return x.id;}).toList(); // get tables of same size and select only ids
  }
  else{
      throw Exception("Both list parameters were null!");
  }

  var frequency = [for (var i = 0; i < filteredTableIds.length; i++) false]; // generate frequency vector

  for(var id in filteredTableIds){
    var tableIndex = int.parse(id.substring(1));

    if (tableIndex - 1 < filteredTableIds.length) {
      frequency[tableIndex - 1] = true; // indexing starts from 0, subtract
    }
  }
  //search 
  for(var i = 0; i < frequency.length; i++){
    if(frequency[i] == false) {
      return "${getTableLetterFromSize()}${i + 1}";
    } //indexing starts from 0;
  }

  // no unused index was found, return length + 1
  return "${getTableLetterFromSize()}${frequency.length + 1}";
}
