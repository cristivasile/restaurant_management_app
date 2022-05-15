class ReservationModel {
  late int numberOfPeople;
  late String name;
  late DateTime dateTime;
  late String tableId;

  ReservationModel(
      {required this.numberOfPeople,
      required this.name,
      required this.dateTime,
      required this.tableId});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    numberOfPeople = json['numberOfPeople'];
    dateTime = DateTime.parse(json['dateTime']);
    tableId = json['tableId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numberOfPeople': numberOfPeople,
      'dateTime': dateTime, //yyyy-mm-dd hh:min:sec
      'tableId': tableId
    };
  }
}
