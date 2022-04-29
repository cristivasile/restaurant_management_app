import 'package:flutter/material.dart';
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
