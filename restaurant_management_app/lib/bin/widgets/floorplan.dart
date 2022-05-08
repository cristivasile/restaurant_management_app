import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/entities/table_list.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';
import 'package:restaurant_management_app/bin/services/table_service.dart';
import 'package:restaurant_management_app/bin/widgets/table_widget.dart';

/// Floor plan builder
class FloorPlan extends StatefulWidget {
  const FloorPlan({Key? key}) : super(key: key);

  @override
  State<FloorPlan> createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
  late BoxConstraints _tablesBoxConstraints;
  String addDropdownValue = '2';
  late String removeDropdownValue = 'none';
  late List<MovableTableWidget> _tableWidgets = [];
  late List<TableModel> _tableModelList = []; //required for the first initialization of _tableWidgets
  late List<String> _tableIds = ['none'];
  late bool read = false;

  @override
  void initState(){
    super.initState();
    init();
  }

  //separate function because it is async and initState can not be async
  Future<void> init() async{
    _tableModelList = await TableList.getTableList();
    setState(() {
      read = true;

      if(_tableModelList.isNotEmpty){ //dropdown must have at least one value, only update if tables exist
        _tableIds = _tableModelList.map((e) => e.id).toList();
        _tableIds.sort();
        removeDropdownValue = _tableIds[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container( // for background color
        color: accent1Color,
        child: Column(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 1 / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container( // add table group
                    // container is necessary bc. it groups the selector and button together
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(  //table size selector
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
                            items: <String>['2', '3', '4', '6', '8']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        //add table button
                        FloatingActionButton(
                          onPressed: () => {addTable()},
                          child: const Icon(Icons.add),
                          backgroundColor: mainColor,
                        ),
                      ],
                    ),
                  ),
                   // ignore: avoid_unnecessary_containers
                  Container(
                    // container is necessary bc. it groups the selector and button together
                    child: Row( // add table group
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(  //table size selector
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
                            items: _tableIds
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        //add table button
                        FloatingActionButton(
                          onPressed: () => {deleteTable()},
                          child: const Icon(Icons.delete),
                          backgroundColor: mainColor,
                        ),
                      ],
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    // container is necessary bc. it groups the text and button together
                    child: Row( // add table group
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5,),
                          child: const Text("Save")
                          ),
                        // save changes button
                        FloatingActionButton(
                          onPressed: () => {saveTables()},
                          child: const Icon(Icons.save),
                          backgroundColor: mainColor,
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
            // Container for the displayed tables
              Container(// for floor color and margin
                color: accent2Color,
                margin: const EdgeInsets.all(floorMargin),
                child: SizedBox( // defines fixed size for child Stack that would be infinite.
                  width: constraints.maxWidth - (floorMargin * 2), // - margin * 2
                  height: (constraints.maxHeight * 7 / 8) - (floorMargin * 2), // - margin * 2
                  child: LayoutBuilder(builder: (context, childConstraints) {
                    _tablesBoxConstraints = childConstraints;
              
                    if (read) {
                      // load tables from TableList
                      _tableWidgets = getWidgetsFromTables(
                          _tableModelList, childConstraints);
                    }
              
                    return Stack(
                      children: _tableWidgets,
                    );
                  }),
                ),
              ),
          ],
        ),
      );
    });


    
  }

  void addTable() {
    UniqueKey key = UniqueKey();
    MovableTableWidget newTableWidget = MovableTableWidget(
          key: key, //tables must have a key, otherwise states can jump over to another object
          constraints: _tablesBoxConstraints,
          tableSize: int.parse(addDropdownValue),
          position: Offset.zero,
          id: generateTableId(tableSize: int.parse(addDropdownValue), tableWidgets: _tableWidgets),
      );

    setState(() {
      _tableWidgets.add(newTableWidget);

      if(_tableIds[0] == 'none') { // if list is empty -> only happens when adding the first table
        _tableIds = [];
      }

      _tableIds.add(newTableWidget.id);
      _tableIds.sort();
      removeDropdownValue = _tableIds[0];
    });

    TableList.addTable(getTableModelFromWidget(newTableWidget));
  }

  void deleteTable() async{
    final String id = removeDropdownValue;
    if(id != 'none'){ //check that a table is selected
      TableList.removeTable(id);

      setState(() {
        _tableWidgets.removeWhere((element) => element.id == id);
        _tableIds.removeWhere((element) => element == id);

        if(_tableIds.isEmpty) { //check if list is empty because it will cause an exception
          _tableIds.add('none');
        }

        removeDropdownValue = _tableIds[0];
      });
    }
  }
}
