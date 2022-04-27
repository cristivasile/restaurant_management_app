import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/table.dart';

/// Floor plan builder
class FloorPlan extends StatefulWidget {
  const FloorPlan({Key? key}) : super(key: key);

  @override
  State<FloorPlan> createState() => _FloorPlanState();
}

bool firstBuild = true;

class _FloorPlanState extends State<FloorPlan> {
  late BoxConstraints _tablesBoxConstraints;
  List<MovableTable> _tables = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 1 / 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => {addTable()},
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.lightGreen,
                )
              ],
            ),
          ),
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 7 / 8,
            child: LayoutBuilder(builder: (context, childConstraints) {
              _tablesBoxConstraints = childConstraints;

              if (firstBuild) {
                // load tables from somewhere on first build
                firstBuild = false;
                _tables = loadTables();
              }

              return Stack(
                children: _tables,
              );
            }),
          ),
        ],
      );
    });
  }

  /// Adds a new table widget to the table list
  ///
  void addTable() {
    //TODO - Add size picker
    setState(() {
      _tables.add(MovableTable(
          constraints: _tablesBoxConstraints,
          tableSize: 2,
          position: Offset.zero));
    });
  }

  /// Loads data and generates table widgets to load into the table list
  ///
  List<MovableTable> loadTables() {
    //TODO - Load from somewhere
    List<MovableTable> result = [];

    result.add(MovableTable(
      constraints: _tablesBoxConstraints,
      tableSize: 2,
      position: const Offset(850, 50),
    ));
    result.add(MovableTable(
      constraints: _tablesBoxConstraints,
      tableSize: 3,
      position: const Offset(550, 150),
    ));
    result.add(MovableTable(
      constraints: _tablesBoxConstraints,
      tableSize: 4,
      position: const Offset(25, 425),
    ));
    result.add(MovableTable(
      constraints: _tablesBoxConstraints,
      tableSize: 6,
      position: const Offset(690, 300),
    ));
    result.add(MovableTable(
      constraints: _tablesBoxConstraints,
      tableSize: 8,
      position: const Offset(260, 420),
    ));
    return result;
  }
}
