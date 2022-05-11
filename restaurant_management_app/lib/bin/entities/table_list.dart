import 'package:restaurant_management_app/bin/models/table_model.dart';
import 'package:restaurant_management_app/bin/services/table_service.dart';

TableList? object;

class TableList {
  late List<TableModel> _tables;
  TableList._();

  static Future<List<TableModel>> getTableList() async {
    if(object == null){
      object = TableList._();
      object!._tables = await loadTables();
    }

    return object!._tables;
  }

  static void setTableList(List<TableModel> newTables){
    object ??= TableList._();
    object!._tables = newTables;
  }

  /// Modifies a table's current position in the table list.
  ///
  static void editTablePosition(String id, double xOffset, double yOffset){
    object ??= TableList._();
    List<TableModel> tables = object!._tables;
    for(TableModel table in tables) {
      if(table.id == id){
        table.xOffset = xOffset;
        table.yOffset = yOffset;
      }
    }
  }

  static void addTable(TableModel table){
    object ??= TableList._();
    object!._tables.add(table);
  }

  ///Removes a table with a given id
  static void removeTable(String tableId){
    object ??= TableList._();
    object!._tables.removeWhere((element) => element.id == tableId);
    return;
  }

}
