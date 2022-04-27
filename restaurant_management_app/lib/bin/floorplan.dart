import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/table.dart';

class FloorPlan extends StatefulWidget {
  const FloorPlan({Key? key}) : super(key: key);

  @override
  State<FloorPlan> createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: <Widget>[
          MovableTable(
            constraints: constraints,
            tableSize: 3,
            offset: Offset.zero,
          ),
          MovableTable(
            constraints: constraints,
            tableSize: 2,
            offset: Offset.zero,
          ),
          MovableTable(
            constraints: constraints,
            tableSize: 4,
            offset: Offset.zero,
          ),
          MovableTable(
            constraints: constraints,
            tableSize: 6,
            offset: Offset.zero,
          ),
          MovableTable(
            constraints: constraints,
            tableSize: 8,
            offset: Offset.zero,
          ),
        ],
      );
    });
  }
}
