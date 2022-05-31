import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/entities/table_list.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';
import 'package:restaurant_management_app/bin/services/capacity_service.dart';
import 'package:restaurant_management_app/bin/services/table_service.dart';
import 'package:restaurant_management_app/bin/widgets/floorplantest.dart';
import 'package:restaurant_management_app/bin/widgets/table_widget.dart';

import '../entities/capacity_list.dart';
import 'custom_button.dart';

/// Floor plan builder
class FloorPlan extends StatefulWidget {
  const FloorPlan(Key? key) : super(key: key);

  @override
  State<FloorPlan> createState() => _FloorPlanState();
}

const double buttonRowRatio = 1 / 8;
const double floorSectionRatio = 1 - buttonRowRatio;
const double buttonSize = 45;

class _FloorPlanState extends State<FloorPlan> {
  late BoxConstraints _tablesBoxConstraints;
  int _currentFloor = 0;
  String _addDropdownValue = '2';
  String _removeDropdownValue = 'none';
  List<MovableTableWidget> _tableWidgets = [];
  List<TableModel> _tableModelList = []; //required for the first initialization of _tableWidgets
  List<String> _tableIds = ['none'];
  List<int> _floorCapacities = []; 
  bool _read = false;
  bool _firstBuild = true;
  int _currentSeats = 0;

  @override
  void initState() {
    super.initState();
    _tableModelList = TableList.getTableList();
    _floorCapacities = CapacityList.getCapacityList();
    setState(() {
      _read = true;

      if (_tableModelList.isNotEmpty) {
        //dropdown must have at least one value, only update if tables exist
        _tableIds = _tableModelList.map((e) => e.id).toList();
        _tableIds.sort();
        _removeDropdownValue = _tableIds[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentSeats = getCurrentSeatNumber();
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        // for background color
        color: accent1Color,
        child: Column(
          children: [
            SizedBox(
              // top container
              width: constraints.maxWidth,
              height: constraints.maxHeight * buttonRowRatio,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Container is necessary for grouping
                  // ignore: avoid_unnecessary_containers
                  Column( // <Group> +/- controls
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row( // <Group> Floor controls
                        children: [
                          const Text("Current floor: "),
                          TextButton(
                            onPressed: () => incrementFloor(),
                            child: const Text("+", style: TextStyle(fontWeight: FontWeight.bold)),
                            style: TextButton.styleFrom(primary: mainColor),
                          ),
                          Text("$_currentFloor"),
                          TextButton(
                            onPressed: () => decrementFloor(),
                            child: const Text("-", style: TextStyle(fontWeight: FontWeight.bold)),
                            style: TextButton.styleFrom(primary: mainColor),
                          ),
                        ],
                      ),
                      Row( // <Group> Seat capacity controls
                      children: [
                        const Text("Floor capacity: "),
                        TextButton(
                          onPressed: () => incrementCapacity(),
                          child: const Text("+", style: TextStyle(fontWeight: FontWeight.bold)),
                          style: TextButton.styleFrom(primary: mainColor),
                        ),
                        Text("$_currentSeats / ${_floorCapacities[_currentFloor] == -1? "∞" : _floorCapacities[_currentFloor]}"),
                        TextButton(
                          onPressed: () => decrementCapacity(),
                          child: const Text("-", style: TextStyle(fontWeight: FontWeight.bold)),
                          style: TextButton.styleFrom(primary: mainColor),
                        ),
                      ],
                    )
                    ],
                  ),
                  // Container is necessary for grouping
                  // ignore: avoid_unnecessary_containers
                  Container(
                    // <Add Table> GROUP
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            //table size selector
                            value: _addDropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: mainColor,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _addDropdownValue = newValue!;
                              });
                            },
                            items: ['2', '3', '4', '6', '8'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        //add table button
                        CustomButton(
                          size: buttonSize,
                          icon: const Icon(Icons.add),
                          color: mainColor,
                          function: () => addTable()
                        ),
                      ],
                    ),
                  ),
                  // Container is necessary for grouping
                  // ignore: avoid_unnecessary_containers
                  Container(
                    // <Delete Table> GROUP
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            //table size selector
                            value: _removeDropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: mainColor,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _removeDropdownValue = newValue!;
                              });
                            },
                            items: _tableIds.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        //delete table button
                        CustomButton(
                          size: buttonSize,
                          icon: const Icon(Icons.delete),
                          color: mainColor,
                          function: () => {deleteTable()},
                        ),
                      ],
                    ),
                  ),
                  // Container is necessary for grouping
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Row(
                      // save changes group
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                              right: 5,
                            ),
                            child: const Text("Save")),
                        // save changes button
                        CustomButton(
                          size: buttonSize,
                          icon: const Icon(Icons.save),
                          color: mainColor,
                          function: () => {save()},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container for the displayed tables
            Container(
              // for floor color and margin
              color: accent2Color,
              margin: const EdgeInsets.all(floorMargin),
              child: SizedBox(
                // defines fixed size for child Stack that would be infinite.
                width: constraints.maxWidth - (floorMargin * 2), // - margin * 2
                height: (constraints.maxHeight * floorSectionRatio) -
                    (floorMargin * 2), // - margin * 2
                child: LayoutBuilder(builder: (context, childConstraints) {
                  _tablesBoxConstraints = childConstraints;

                  if (_read && _firstBuild) {
                    // load tables from TableList
                    _firstBuild = false;
                    _tableWidgets =
                        getWidgetsFromTables(_tableModelList, childConstraints);
                  }

                  return Stack(
                    children: _tableWidgets
                        .where((element) => element.floor == _currentFloor)
                        .toList(), //filter only tables on the current floor
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> addTable() async{
    UniqueKey key = UniqueKey();
    int tableSize = int.parse(_addDropdownValue);
    int capacity = _floorCapacities[_currentFloor];
    if(capacity == -1 || tableSize + _currentSeats <= capacity){
      MovableTableWidget newTableWidget = MovableTableWidget(
        key:
            key, //tables must have a key, otherwise states can jump over to another object
        constraints: _tablesBoxConstraints,
        tableSize: int.parse(_addDropdownValue),
        position: Offset.zero,
        floor: _currentFloor,
        id: generateTableId(
            tableSize: int.parse(_addDropdownValue), tableWidgets: _tableWidgets),
      );

      setState(() {
        _tableWidgets.add(newTableWidget);
        if (_tableIds[0] == 'none') {
          // if list is empty -> only happens when adding the first table
          _tableIds = [];
        }

        _tableIds.add(newTableWidget.id);
        _tableIds.sort();
        _removeDropdownValue = _tableIds[0];
      });

      TableList.addTable(getTableModelFromWidget(newTableWidget));
    }
    else{
      await showDialog(
        context: context,  
        builder: (BuildContext context) {  
         return AlertDialog(  
            title: const Text("Operation failed"),  
            content: const Text("Cannot add a new table because the seat limit would be exceeded!"),  
            actions: [  
              TextButton(  
              child: const Text("OK",style: TextStyle(color: Colors.redAccent)),  
              onPressed: () {  
              Navigator.of(context).pop();  
              },  
            ),   
            ],  
          );    
        },  
      );
    }
  }

  void deleteTable() {
    final String id = _removeDropdownValue;
    if (id != 'none') {
      //check that a table is selected
      TableList.removeTable(id);

      setState(() {
        _tableWidgets.removeWhere((element) => element.id == id);
        _tableIds.removeWhere((element) => element == id);

        if (_tableIds.isEmpty) {
          //check if list is empty because it will cause an exception
          _tableIds.add('none');
        }

        _removeDropdownValue = _tableIds[0];
      });
    }
  }

  void incrementFloor() {
    if (_currentFloor < maxFloors) {
      setState(() {
        _currentFloor += 1;
      });
    }
  }

  void decrementFloor() {
    if (_currentFloor > 0) {
      setState(() {
        _currentFloor -= 1;
      });
    }
  }

  void incrementCapacity(){
      setState(() {
        if(_floorCapacities[_currentFloor] == -1) {
          _floorCapacities[_currentFloor] = _currentSeats;
        }
        else{
          _floorCapacities[_currentFloor] += 1;
        }
      });
  }

  void decrementCapacity(){
      setState(() {
        if(_floorCapacities[_currentFloor] == _currentSeats) {
          _floorCapacities[_currentFloor] = -1;
        }
        else if(_floorCapacities[_currentFloor] != -1) {
          _floorCapacities[_currentFloor] -= 1;
        }
      });
  }

  void save(){
    saveTables();
    CapacityList.setCapacities(_floorCapacities); // set capacity list and save
    saveCapacities();
  }

  int getCurrentSeatNumber(){
    int result = 0;

    for(var table in _tableModelList.where((element) => element.floor == _currentFloor)) {
      result += table.tableSize;
    }

    return result;
  }
}
