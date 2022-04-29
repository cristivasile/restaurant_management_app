// ignore: file_names
import 'package:flutter/material.dart';
import '../models/table.dart' as table_model;
import '../widgets/tableWidget.dart';

/// Returns a list of MovableTable from a list of tables
///
/// @param tables: a list of tables
/// @param constraints: a MovableTable needs the BoxConstraints from where it is created
List<MovableTable> getWidgetsFromTables(
    List<table_model.Table> tables, BoxConstraints constraints) {
  List<MovableTable> result = [];

  for (table_model.Table table in tables) {
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
List<table_model.Table> getTablesFromTableWidgets(
    List<MovableTable> tableWidgets) {
  List<table_model.Table> tables = [];

  for (MovableTable widget in tableWidgets) {
    tables.add(table_model.Table(
        id: widget.id,
        xOffset: widget.position.dx,
        yOffset: widget.position.dy,
        tableSize: widget.tableSize));
  }

  return tables;
}

/// Loads a list of tables and returns it
///
List<table_model.Table> loadTables() {
//TODO - load from disk or db
  List<table_model.Table> result = [];

  //TODO - delete placeholder table list
  result.add(
      table_model.Table(tableSize: 2, xOffset: 850, yOffset: 50, id: "A1"));
  result.add(
      table_model.Table(tableSize: 3, xOffset: 550, yOffset: 150, id: "B1"));
  result.add(
      table_model.Table(tableSize: 4, xOffset: 25, yOffset: 150, id: "C1"));
  result.add(
      table_model.Table(tableSize: 6, xOffset: 690, yOffset: 300, id: "D1"));
  result.add(
      table_model.Table(tableSize: 8, xOffset: 260, yOffset: 420, id: "E1"));

  return result;
}

///Saves tables to disk
///
///@param tables: MovableTable widgets
void saveTables(List<MovableTable> tables) {
  List<table_model.Table> toSave = getTablesFromTableWidgets(tables);
  //TODO - save somewhere
}


/// Generates unique ID for a table. Must receive either a list of tables or list of tableWidgets.
/// 
/// @param(optional) tables = a list of tables
/// @param(optional)
String generateTableId({List<table_model.Table>? tables, List<MovableTable>? tableWidgets, required int tableSize}){

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

  print(filteredTableIds);

  var frequency = [for (var i = 0; i < filteredTableIds.length; i++) false]; // generate frequency vector

  for(var id in filteredTableIds){
    var tableIndex = int.parse(id.substring(1));

    if (tableIndex - 1 < filteredTableIds.length) {
      frequency[tableIndex - 1] = true; // indexing starts from 0, subtract
    }
  }
  print(frequency);
  //search 
  for(var i = 0; i < frequency.length; i++){
    if(frequency[i] == false) {
      return "${getTableLetterFromSize()}${i + 1}";
    } //indexing starts from 0;
  }

  // no unused index was found, return length + 1
  return "${getTableLetterFromSize()}${frequency.length + 1}";
}
