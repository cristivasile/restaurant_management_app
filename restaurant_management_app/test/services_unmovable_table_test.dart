import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';
import 'package:restaurant_management_app/bin/services/unmovable_table_service.dart';

void main() {
  var tablesFloor0 = [
    TableModel(id: "A1", xOffset: 0, yOffset: 0, tableSize: 2, floor: 0),
    TableModel(id: "A2", xOffset: 0, yOffset: 0, tableSize: 2, floor: 0)
  ];

  var tablesFloor1 = [
    TableModel(id: "A1", xOffset: 0, yOffset: 0, tableSize: 2, floor: 1)
  ];

  var widgetTables = getWidgetsFromTables(tablesFloor0, () {});

  test('generateTableId: valid table size 2 floor 0', () {
    var result = generateTableId(tables: tablesFloor0, tableSize: 2);
    expect(result, 'A3');
  });

  test('generateTableId: valid table size 2 floor 1', () {
    var result = generateTableId(tables: tablesFloor1, tableSize: 2);
    expect(result, 'A2');
  });

  test('generateTableId: valid table size 3 floor 0', () {
    var result = generateTableId(tables: tablesFloor0, tableSize: 3);
    expect(result, 'B1');
  });

  test('generateTableId: both list parameters are null', () {
    expect(() => generateTableId(tableSize: 2),
        throwsA(isInstanceOf<Exception>()));
  });

  test('generateTableId: invalid parameters provided', () {
    expect(() => generateTableId(tables: tablesFloor0, tableWidgets: widgetTables, tableSize: 2),
        throwsA(isInstanceOf<Exception>()));
  });
}
