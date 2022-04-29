class TableModel {
  late String id;
  late double xOffset, yOffset;
  late int tableSize;

  TableModel(
      {required this.id,
      required this.xOffset,
      required this.yOffset,
      required this.tableSize});

  TableModel.fromJson(Map<String,dynamic> json){
      id = json['id'];
      xOffset = json['xOffset'];
      yOffset = json['yOffset'];
      tableSize = json['tableSize'];
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'xOffset': xOffset,
      'yOffset': yOffset,
      'tableSize': tableSize
    };
  }
}