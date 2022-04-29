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
}
