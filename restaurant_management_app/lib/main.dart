import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/entities/order_list.dart';
import 'package:restaurant_management_app/bin/entities/product_list.dart';
import 'package:restaurant_management_app/bin/entities/reservation_list.dart';
import 'package:restaurant_management_app/bin/widgets/floorplan.dart';
import 'package:restaurant_management_app/bin/widgets/orders.dart';
import 'package:restaurant_management_app/bin/widgets/reservations_widget.dart';

import 'bin/data_providers/data_provider.dart';
import 'bin/widgets/menu.dart';

DataProvider data = JsonProvider();

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProductList.loadProductList();
  await OrderList.loadOrderList();
  await ReservationList.loadReservationList();
}

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.create_outlined), text: "Edit floor plan"),
                Tab(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    text: "View tables and reservations"),
                Tab(
                  icon: Icon(Icons.menu_book_outlined),
                  text: "Edit menu",
                ),
                Tab(
                    icon: Icon(Icons.view_list_outlined),
                    text: "View order list"),
                Tab(
                    icon: Icon(Icons.view_list_outlined),
                    text: "View reservation list"),
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
              const Center(child: Menu()),
              const Center(child: OrdersWidget()),
              const Center(child: ReservationsWidget())
            ],
          ),
        ),
      ),
    );
  }
}
