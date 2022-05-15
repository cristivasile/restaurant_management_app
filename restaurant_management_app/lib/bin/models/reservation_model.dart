class ReservationModel {
  late int numberOfPersons;
  late String name;
  late DateTime dateTime;
  late String tableId;

  ReservationModel(
      {required this.numberOfPersons,
      required this.name,
      required this.dateTime,
      required this.tableId});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    numberOfPersons = json['numberOfPersons'];
    dateTime = json['dateTime'];
    tableId = json['tableId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numberOfPersons': numberOfPersons,
      'dateTime': dateTime, //yyyy-mm-dd hh:min:sec
      'tableId': tableId
    };
  }
}
