import 'package:restaurant_management_app/bin/widgets/reservations_widget.dart';
import 'package:intl/intl.dart';

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

  @override
  String toString() {
    Iterable<String> reservationStrings =
        reservations.map((element) => element.toString());
    String rep = "{\n";
    rep += '"tableId": "$tableId",\n';
    rep += '"name": $name,\n';
    rep += '"dateTime": $dateTime';
    rep += "}";
    return rep;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numberOfPeople': numberOfPeople,
      'dateTime': dateTime.toIso8601String(), //yyyy-mm-dd hh:min:sec
      'tableId': tableId
    };
  }
}
