import 'package:restaurant_management_app/bin/models/table.dart';
import 'package:restaurant_management_app/bin/services/tableService.dart';

TableList? object;

class TableList {
  late List<Table> tables;
  TableList._() {
    tables = loadTables();
  }

  static TableList getTableList() {
    object ??= TableList._();
    return object ?? TableList._();
  }
}
