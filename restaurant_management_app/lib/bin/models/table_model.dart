class TableModel {
  late String id;
  late double xOffset, yOffset;
  late int tableSize;
  late int floor;

  TableModel(
      {required this.id,
      required this.xOffset,
      required this.yOffset,
      required this.tableSize,
      required this.floor});

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    xOffset = json['xOffset'];
    yOffset = json['yOffset'];
    tableSize = json['tableSize'];
    floor = json['floor'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'xOffset': xOffset,
      'yOffset': yOffset,
      'tableSize': tableSize,
      'floor': floor
    };
  }
}
