import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/entities/reservation_list.dart';
import 'package:restaurant_management_app/bin/entities/table_list.dart';
import 'package:restaurant_management_app/bin/models/reservation_model.dart';
import 'package:restaurant_management_app/bin/services/reservation_service.dart';
import 'package:restaurant_management_app/bin/widgets/custom_button.dart';
import 'package:restaurant_management_app/bin/widgets/DateTimePicker/dateTime_picker_widget.dart';

import '../models/table_model.dart';

const double expandedMaxHeight = 400;
List<ReservationModel> reservations = ReservationList.getReservationList();

class ReservationsWidget extends StatefulWidget {
  const ReservationsWidget({Key? key}) : super(key: key);

  @override
  State<ReservationsWidget> createState() => _ReservationsWidgetState();
}

class _ReservationsWidgetState extends State<ReservationsWidget> {
  List<ReservationModel> _reservations = [];
  List<TableModel> _tables = [];

  String _chosenTable = '';
  DateTime _currentDate = DateTime.now();
  DatetimePickerWidget dateTimeButton = DatetimePickerWidget();
  final TextEditingController _reservationNameController =
      TextEditingController();

  String _dialogErrorMessage = "";
  String _dialogName = "";
  @override
  void initState() {
    super.initState();
    _reservations = ReservationList.getReservationList();
    _tables = TableList.getTableList();
    _chosenTable = _tables[0].id;
  }

  @override
  void dispose() {
    _reservationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("MM/dd HH:mm");
    // return ListView.builder(
    //     controller: ScrollController(),
    //     itemBuilder: (BuildContext context, int index) {
    //       return ReservationSection(
    // title: '    ' +
    //     reservations[index].tableId +
    //     ' : ' +
    //     dateFormat.format(reservations[index].dateTime).toString() +
    //     ', ' +
    //     reservations[index].name,
    // reservationModel: reservations[index]);
    //     },
    //     itemCount: reservations.length);

    return LayoutBuilder(builder: (context, constraints) {
      return Column(children: [
        SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 9 / 10,
          child: ListView.builder(
            controller: ScrollController(),
            itemBuilder: (BuildContext context, int index) {
              return ReservationSection(
                  title: '    ' +
                      reservations[index].tableId +
                      ' : ' +
                      dateFormat
                          .format(reservations[index].dateTime)
                          .toString() +
                      ', ' +
                      reservations[index].name,
                  reservationModel: reservations[index]);
            },
            itemCount: reservations.length,
          ),
        ),
        SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 1 / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  color: const Color.fromARGB(255, 121, 8, 0),
                  size: 50,
                  icon: const Icon(Icons.add),
                  function: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: const Text(
                                'Add Reservation',
                                style: TextStyle(color: mainColor),
                              ),
                              content: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            "Set table",
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: DropdownButton<String>(
                                                  value: _chosenTable,
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  underline: Container(
                                                    height: 2,
                                                    color: mainColor,
                                                  ),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      _chosenTable = newValue!;
                                                    });
                                                  },
                                                  items: _tables.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (TableModel value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value.id,
                                                      child: Text(value.id),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            "Set Reservation Time",
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  height: 30,
                                                  width: 300,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: dateTimeButton)
                                            ],
                                          ),
                                          TextField(
                                            decoration: const InputDecoration(
                                                hintText: "Enter Name"),
                                            controller:
                                                _reservationNameController,
                                          ),
                                          Text(
                                            _dialogErrorMessage,
                                            style: const TextStyle(
                                                color: Colors.redAccent),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                              actions: [
                                TextButton(
                                  child: const Text("Add"),
                                  onPressed: () {
                                    setState(() {
                                      _dialogErrorMessage = "";
                                    });

                                    String? name =
                                        _reservationNameController.text;

                                    setState(() {
                                      _dialogName =
                                          _reservationNameController.text;
                                    });

                                    int ok = 1;
                                    createReservation();

                                    _reservationNameController.text = "";
                                    _dialogName = "";
                                    Navigator.of(context).pop();
                                  },
                                  style:
                                      TextButton.styleFrom(primary: mainColor),
                                ),
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style:
                                      TextButton.styleFrom(primary: mainColor),
                                ),
                              ],
                            );
                          });
                        });
                  },
                )
              ],
            ))
      ]);
    });
  }

  void createReservation() async {
    int numberOfPeople = 0;
    if (_chosenTable.startsWith('A')) {
      numberOfPeople = 2;
    } else if (_chosenTable.startsWith('B')) {
      numberOfPeople = 3;
    } else if (_chosenTable.startsWith('C')) {
      numberOfPeople = 4;
    } else if (_chosenTable.startsWith('D')) {
      numberOfPeople = 6;
    } else {
      numberOfPeople = 8;
    }
    ReservationModel newReservation = ReservationModel(
        numberOfPeople: numberOfPeople,
        name: _dialogName,
        dateTime: dateTimeButton.getInfo(),
        tableId: _chosenTable);

    bool valid = await ReservationList.addReservation(newReservation);

    if (!valid) {
      setState(() {
        _dialogErrorMessage = "Table already reserved";
      });
      return;
    }
    saveReservations();

    setState(() {
      reservations = ReservationList.getReservationList();
    });
  }
}

class ReservationSection extends StatefulWidget {
  final String title;
  final ReservationModel reservationModel;

  const ReservationSection(
      {Key? key, required this.title, required this.reservationModel})
      : super(key: key);

  @override
  _ReservationSectionState createState() => _ReservationSectionState();
}

class _ReservationSectionState extends State<ReservationSection> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        child: Column(
          children: <Widget>[
            Container(
              color: accent1Color,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
