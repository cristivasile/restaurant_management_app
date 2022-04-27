import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Floor plan editor'),
        ),
        body: const Center(
          child: FloorPlan(),
        ),
      ),
    );
  }
}

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
          MovableTable(constraints: constraints),
          MovableTable(constraints: constraints),
        ],
      );
    });
  }
}

