import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/entities/table_list.dart';
import 'package:restaurant_management_app/bin/models/table_model.dart';
import 'package:restaurant_management_app/bin/services/unmovable_table_service.dart';
import 'package:restaurant_management_app/bin/widgets/unmovable_table_widget.dart';

import 'custom_button.dart';

/// Floor plan builder
class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

const double buttonRowRatio = 1 / 8;
const double floorSectionRatio = 1 - buttonRowRatio;
const double buttonSize = 45;

class _ReservationState extends State<Reservation> {
  int currentFloor = 0;
  List<UnmovableTableWidget> _tableWidgets = [];
  List<TableModel> _tableModelList =
      []; //required for the first initialization of _tableWidgets
  List<String> _tableIds = ['none'];
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

      if (_tableModelList.isNotEmpty) {
        //dropdown must have at least one value, only update if tables exist
        _tableIds = _tableModelList.map((e) => e.id).toList();
        _tableIds.sort();
      }
    });
  }

  void reloadTables() {
    setState(() {
      _tableWidgets = _tableWidgets;
    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      rebuildAllChildren(context);
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
                  Container(
                      child: Row(
                    children: [
                      const Text("Current floor: "),
                      TextButton(
                        onPressed: () {
                          incrementFloor();
                        },
                        child: const Text("+",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: TextButton.styleFrom(primary: mainColor),
                      ),
                      Text(currentFloor.toString()),
                      TextButton(
                        onPressed: () {
                          decrementFloor();
                        },
                        child: const Text("-",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: TextButton.styleFrom(primary: mainColor),
                      ),
                    ],
                  )),
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
                width: constraints.maxWidth - (floorMargin * 2), // - margin * 2
                height: (constraints.maxHeight * floorSectionRatio) -
                    (floorMargin * 2), // - margin * 2
                child: LayoutBuilder(builder: (context, childConstraints) {
                  if (_read && _firstBuild) {
                    // load tables from TableList
                    _firstBuild = false;
                    _tableWidgets =
                        getWidgetsFromTables(_tableModelList, reloadTables);
                  }

                  return Stack(
                      children: _tableWidgets
                          .where((element) => element.floor == currentFloor)
                          .toList() //filter only tables on the current floor
                      );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }

  void incrementFloor() async {
    if (currentFloor < 10) {
      setState(() {
        currentFloor += 1;
      });
    }
  }

  void decrementFloor() async {
    if (currentFloor > 0) {
      setState(() {
        currentFloor -= 1;
      });
    }
  }
}
