import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/entities/table_list.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';
import 'package:restaurant_management_app/bin/services/table_service.dart';
import 'package:restaurant_management_app/bin/widgets/table_widget.dart';

import 'custom_button.dart';

class AddTableWidget extends StatefulWidget {
  const AddTableWidget(Key? key) : super(key: key);

  @override
  State<AddTableWidget> createState() => _AddTableWidgetState();
}

class _AddTableWidgetState extends State<AddTableWidget> {
  String _addDropdownValue = '2';

  @override
  Widget build(BuildContext context) {
    //ignore: avoid_unnecessary_containers
    return Container(
        child: Row(children: [
      Container(
          margin: const EdgeInsets.all(10.0),
          child: DropdownButton<String>(
              //table size selector
              value: _addDropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 8,
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
              items: ['2', '3', '4', '6', '8']
                  .map((String value) =>
                      DropdownMenuItem(value: value, child: Text(value)))
                  .toList())),
      CustomButton(
          size: buttonSize,
          icon: const Icon(Icons.add),
          color: mainColor,
          function: () => addTable(_addDropdownValue))
    ]));
  }

  void addTable(String value) {
    UniqueKey key = UniqueKey();
    MovableTableWidget newTableWidget = MovableTableWidget(
        key: key,
        constraints: boxConstraints,
        tableSize: int.parse(_addDropdownValue),
        position: Offset.zero,
        floor: currentFloor,
        id: generateTableId(
            tableSize: int.parse(_addDropdownValue), tableWidgets: tblWidgets));

    setState(() {
      tblWidgets.add(newTableWidget);
      if (tblIds[0] == 'none') {
        // if list is empty -> only happens when adding the first table
        tblIds = [];
      }

      tblIds.add(newTableWidget.id);
      tblIds.sort();
      removeDropdownValue = tblIds[0];
    });

    TableList.addTable(getTableModelFromWidget(newTableWidget));
  }
}

const double buttonRowRatio = 1 / 8;
const double floorSectionRatio = 1 - buttonRowRatio;
const double buttonSize = 45;
List<MovableTableWidget> tblWidgets = [];
List<String> tblIds = ['none'];
int currentFloor = 0;
late BoxConstraints boxConstraints;
String addDropdownValue = '2';
late String removeDropdownValue = 'none';

class FloorPlan extends StatefulWidget {
  const FloorPlan(Key? key) : super(key: key);

  @override
  State<FloorPlan> createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
  // late BoxConstraints _tablesBoxConstraints;
  // int currentFloor = 0;
  // String _addDropdownValue = '2';
  // String _removeDropdownValue = 'none';
  // List<MovableTableWidget> _tableWidgets = [];
  // List<TableModel> _tableModelList = [];
  // List<String> _tableIds = ['none'];
  // bool _read = false;
  // bool _firstBuild = true;

  List<TableModel> _tableModelList = [];
  bool _read = false;
  bool _firstBuild = true;


  @override
  void initState() {
    super.initState();
    init();
  }

  //separate function because it is async and initState can not be async
  Future<void> init() async {
    _tableModelList = await TableList.getTableList();
    setState(() {
      _read = true;

      // if (_tableModelList.isNotEmpty) {
      //   //dropdown must have at least one value, only update if tables exist
      //   _tableIds = _tableModelList.map((e) => e.id).toList();
      //   _tableIds.sort();
      //   _removeDropdownValue = _tableIds[0];

      //   tblIds = _tableModelList.map((e) => e.id).toList();
      //   tblIds.sort();
      //   _removeDropdownValue = tblIds[0];
      // }

      if (_tableModelList.isNotEmpty) {
        //dropdown must have at least one value, only update if tables exist
        tblIds = _tableModelList.map((e) => e.id).toList();
        tblIds.sort();
        removeDropdownValue = tblIds[0];

        tblIds = _tableModelList.map((e) => e.id).toList();
        tblIds.sort();
        removeDropdownValue = tblIds[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  AddTableWidget(UniqueKey()),
                  // Container is necessary for grouping
                  // ignore: avoid_unnecessary_containers
                  Container(
                      // <Change Floor> GROUP
                      child: Row(
                    children: [
                      const Text("Current floor: "),
                      TextButton(
                        onPressed: () => incrementFloor(),
                        child: const Text("+",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: TextButton.styleFrom(primary: mainColor),
                      ),
                      Text(currentFloor.toString()),
                      TextButton(
                        onPressed: () => decrementFloor(),
                        child: const Text("-",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: TextButton.styleFrom(primary: mainColor),
                      ),
                    ],
                  )),
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
                            value: addDropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: mainColor,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                addDropdownValue = newValue!;
                              });
                            },
                            items: ['2', '3', '4', '6', '8']
                                .map<DropdownMenuItem<String>>((String value) {
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
                            function: () => addTable()),
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
                            value: removeDropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: mainColor,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                removeDropdownValue = newValue!;
                              });
                            },
                            items: tblIds
                                .map<DropdownMenuItem<String>>((String value) {
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
                          function: () => {saveTables()},
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
                width: constraints.maxWidth - floorMargin * 2,
                height:
                    constraints.maxHeight * floorSectionRatio - floorMargin * 2,
                child: LayoutBuilder(builder: (context, constraints) {
                  boxConstraints = constraints;

                  if (_read && _firstBuild) {
                    // load tables from TableList
                    _firstBuild = false;
                    tblWidgets =
                        getWidgetsFromTables(_tableModelList, boxConstraints);
                  }

                  return Stack(
                    children: tblWidgets
                        .where((element) => element.floor == currentFloor)
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

  // void addTable() {
  //   UniqueKey key = UniqueKey();
  //   MovableTableWidget newTableWidget = MovableTableWidget(
  //     key:
  //         key, //tables must have a key, otherwise states can jump over to another object
  //     constraints: _tablesBoxConstraints,
  //     tableSize: int.parse(_addDropdownValue),
  //     position: Offset.zero,
  //     floor: currentFloor,
  //     id: generateTableId(
  //         tableSize: int.parse(_addDropdownValue), tableWidgets: tblWidgets),
  //   );

  //   setState(() {
  //     tblWidgets.add(newTableWidget);
  //     if (_tableIds[0] == 'none') {
  //       // if list is empty -> only happens when adding the first table
  //       _tableIds = [];
  //     }

  //     _tableIds.add(newTableWidget.id);
  //     _tableIds.sort();
  //     _removeDropdownValue = _tableIds[0];
  //   });

  //   TableList.addTable(getTableModelFromWidget(newTableWidget));
  // }

  // void deleteTable() {
  //   final String id = _removeDropdownValue;
  //   if (id != 'none') {
  //     //check that a table is selected
  //     TableList.removeTable(id);

  //     setState(() {
  //       tblWidgets.removeWhere((element) => element.id == id);
  //       _tableIds.removeWhere((element) => element == id);

  //       if (_tableIds.isEmpty) {
  //         //check if list is empty because it will cause an exception
  //         _tableIds.add('none');
  //       }

  //       _removeDropdownValue = _tableIds[0];
  //     });
  //   }
  // }


  void addTable() {
    UniqueKey key = UniqueKey();
    MovableTableWidget newTableWidget = MovableTableWidget(
      key:
          key, //tables must have a key, otherwise states can jump over to another object
      constraints: boxConstraints,
      tableSize: int.parse(addDropdownValue),
      position: Offset.zero,
      floor: currentFloor,
      id: generateTableId(
          tableSize: int.parse(addDropdownValue), tableWidgets: tblWidgets),
    );

    setState(() {
      tblWidgets.add(newTableWidget);
      if (tblIds[0] == 'none') {
        // if list is empty -> only happens when adding the first table
        tblIds = [];
      }

      tblIds.add(newTableWidget.id);
      tblIds.sort();
      removeDropdownValue = tblIds[0];
    });

    TableList.addTable(getTableModelFromWidget(newTableWidget));
  }

  void deleteTable() {
    final String id = removeDropdownValue;
    if (id != 'none') {
      //check that a table is selected
      TableList.removeTable(id);

      setState(() {
        tblWidgets.removeWhere((element) => element.id == id);
        tblIds.removeWhere((element) => element == id);

        if (tblIds.isEmpty) {
          //check if list is empty because it will cause an exception
          tblIds.add('none');
        }

        removeDropdownValue = tblIds[0];
      });
    }
  }

  void incrementFloor() {
    if (currentFloor < 10) {
      setState(() {
        currentFloor += 1;
      });
    }
  }

  void decrementFloor() {
    if (currentFloor > 0) {
      setState(() {
        currentFloor -= 1;
      });
    }
  }
}
