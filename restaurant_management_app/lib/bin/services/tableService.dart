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
      table_model.Table(tableSize: 3, xOffset: 550, yOffset: 150, id: "A2"));
  result.add(
      table_model.Table(tableSize: 4, xOffset: 25, yOffset: 150, id: "A3"));
  result.add(
      table_model.Table(tableSize: 6, xOffset: 690, yOffset: 300, id: "A4"));
  result.add(
      table_model.Table(tableSize: 8, xOffset: 260, yOffset: 420, id: "A5"));

  return result;
}

///Saves tables to disk
///
///@param tables: MovableTable widgets
void saveTables(List<MovableTable> tables) {
  List<table_model.Table> toSave = getTablesFromTableWidgets(tables);
  //TODO - save somewhere
}
