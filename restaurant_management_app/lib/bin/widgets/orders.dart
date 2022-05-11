import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/models/product_model.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/widgets/custom_button.dart';

import '../constants.dart';
import '../entities/product_list.dart';
import '../models/order_model.dart';
import '../entities/order_list.dart';

const double expandedMaxHeight = 400;

List<OrderModel> orders = OrderList.getOrderList();

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  List<ProductModel> _products = [];
  String _dialogErrorMessage = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _products = ProductList.getProductList();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(children: [
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 9 / 10,
            child: ListView.builder(
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  return OrderSection(
                    title: orders[index].tableId +
                        '     ' +
                        orders[index].price.toString(),
                    orderModel: orders[index],
                  );
                },
                itemCount: orders.length),
          ),
          SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 1 / 10,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomButton(
                  color: Colors.orange,
                  size: 50,
                  icon: const Icon(Icons.add),
                  function: () async {
                    //TODO - functie

                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: const Text(
                                "Add new order",
                                style: TextStyle(color: mainColor),
                              ),
                              content: SizedBox(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ////
                                    /// TODO - THIS SHOULD BE A DROPDOWN, FOLLOWED BY A BUTTON TO ADD THE PRODUCT TO THE ORDER'S LIST
                                    /// CHECK DROPDOWN EXAMPLE IN FLOORPLAN.DART
                                    TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter product name"),
                                      controller: nameController,
                                    ),
                                    /// TODO - BUTTON HERE
                                    TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter quantity"),
                                      controller: priceController,
                                    ),
                                    Text(
                                      _dialogErrorMessage,
                                      style: const TextStyle(
                                          color: Colors.redAccent),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Add'),
                                  onPressed: () {
                                    setState(() {
                                      _dialogErrorMessage = "";
                                    });

                                    String name = nameController.text.trim();

                                    if (name.length < 3) {
                                      setState(() {
                                        _dialogErrorMessage =
                                            "Product name must have at least 3 characters!";
                                      });
                                      return;
                                    }

                                    if (name.length > 20) {
                                      setState(() {
                                        _dialogErrorMessage =
                                            "Product name must have at most 20 characters!";
                                      });
                                      return;
                                    }

                                    for (var product
                                        in ProductList.getProductList()) {
                                      if (name.toLowerCase() ==
                                          product.name.toLowerCase()) {
                                        setState(() {
                                          _dialogErrorMessage =
                                              "Product name already exists!";
                                        });
                                        return;
                                      }
                                    }

                                    double? price =
                                        double.tryParse(priceController.text);

                                    if (price == null || price <= 0) {
                                      setState(() {
                                        _dialogErrorMessage =
                                            "Incorrect price! Must be a number higher than 0.";
                                      });
                                      return;
                                    }

                                    /// TODO - ADD PRODUCT TO ORDER LIST
                                    /// CREATE ORDER
                                  },
                                  style:
                                      TextButton.styleFrom(primary: mainColor),
                                ),
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style:
                                      TextButton.styleFrom(primary: mainColor),
                                ),
                              ],
                            );
                          });
                        });
                  },
                )
              ]))
        ]);
      },
    );
  }
}
//               ]),
//             ),
//           ],
//         );
//     );
//   }
// }

//Order section/category widget
class OrderSection extends StatefulWidget {
  final String title;
  final OrderModel orderModel;

  const OrderSection({Key? key, required this.title, required this.orderModel})
      : super(key: key);

  @override
  _OrderSectionState createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Container(
            // top bar containing title and expand button
            color: accent1Color,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    // expand button
                    icon: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        color: mainColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          expandFlag
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
                Text(
                  // Section title
                  widget.title,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                )
              ],
            ),
          ),
          OrderSectionContent(
              // expanded content
              expanded: expandFlag,
              itemCount: widget.orderModel.products.length,
              child: ListView.builder(
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  List<ProductModel> items = widget.orderModel.products;

                  return OrderItem(
                    price: items[index].price,
                    name: items[index].name,
                    quantity: widget.orderModel.quantities[index],
                    category: items[index].category,
                  );
                },
                itemCount: widget.orderModel.products.length,
              ))
        ],
      ),
    );
  }
}

class OrderSectionContent extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  late final double expandedHeight;
  final Widget child;
  final int itemCount;

  OrderSectionContent(
      {Key? key,
      required this.child,
      required this.itemCount,
      this.collapsedHeight = 0.0,
      this.expanded = true})
      : super(key: key) {
    expandedHeight = min(
        expandedMaxHeight, itemCount * 50); //50 is the height of a OrderItem
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      //expand animation
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}

//Single item in a section's expanded tab
class OrderItem extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  late final double totalPrice;
  final String category;

  OrderItem({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category,
  }) : super(key: key) {
    totalPrice = price * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: accent1Color),
          color: accent2Color),
      child: ListTile(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(name + ' X' + quantity.toString()),
          Text(totalPrice.toString()),
        ]),
        leading: Icon(
          sectionIcons[category],
          color: mainColor,
        ),
      ),
    );
  }
}
