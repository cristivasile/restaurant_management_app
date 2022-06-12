import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';

void main() {
  var tableModel =
      TableModel(id: "A1", xOffset: 0.0, yOffset: 0.0, tableSize: 2, floor: 0);
  var tableJson = {
    "id": "A1",
    "xOffset": 0.0,
    "yOffset": 0.0,
    "tableSize": 2,
    "floor": 0
  };

  test('toJson: valid table size 2 floor 0 to Json', () {
    var result = tableModel.toJson();
    expect(result, tableJson);
  });
}
