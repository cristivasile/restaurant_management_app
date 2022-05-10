import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/widgets/floorplan.dart';

import 'bin/data_providers/data_provider.dart';

DataProvider data = JsonProvider();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.create_outlined), text: "Edit floor plan"),
              Tab(icon: Icon(Icons.remove_red_eye_outlined), text: "View tables and reservations"),
              Tab(icon: Icon(Icons.view_list_outlined), text: "View order list"),
            ],
          ),
          title: const Text('Floor plan editor'),
          backgroundColor: mainColor,
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: [
            Center(child: FloorPlan(key: UniqueKey())),
            const Center(child: Text("Not implemented")),
            const Center(child: Text("Not implemented")),
            ],
          ),
        ),
      ),
    );
  }
}