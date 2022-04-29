import 'package:restaurant_management_app/bin/models/table.dart';
import 'package:restaurant_management_app/bin/services/tableService.dart';

TableList? object;

class TableList {
  late List<Table> _tables;
  TableList._() {
    _tables = loadTables();
  }

  static List<Table> getTableList() {
    object ??= TableList._();
    return object!._tables;
  }

  static void setTableList(List<Table> newTables){
    object ??= TableList._();
    object!._tables = newTables;
  }
}
