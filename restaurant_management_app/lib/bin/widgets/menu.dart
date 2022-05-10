import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'dart:math';

import '../models/product_model.dart';

const double expandedMaxHeight = 400;

List<String> sections = [
  "Appetizers",
  "Main courses",
  "Sides",
  "Soft drinks",
  "Spirits"
];

Map sectionIcons = {
  'Appetizers': Icons.apple,
  'Main courses': Icons.food_bank,
  'Sides': Icons.food_bank_outlined,
  'Soft drinks': Icons.local_drink,
  'Spirits': Icons.wine_bar
};

//TODO - delete hardcoded list
List<ProductModel> products = [
  ProductModel(category: "Appetizers", price: 103.5, name: "Appetizer #1"),
  ProductModel(name: "Whiskey", price: 235, category: "Spirits"),
  ProductModel(name: "Vodka", price: 214, category: "Spirits"),
  ProductModel(name: "Red meat", price: 143, category: "Main courses"),
  ProductModel(name: "Irish schnitzel", price: 72, category: "Main courses"),
  ProductModel(name: "Coca cola", price: 30, category: "Soft drinks"),
  ProductModel(name: "Sprite", price: 32, category: "Soft drinks"),
  ProductModel(name: "Fanta", price: 28.54, category: "Soft drinks"),
  ProductModel(name: "French fries", price: 27, category: "Sides"),
  ProductModel(name: "Drunk fish", price: 929, category: "Main courses"),
  ProductModel(name: "Soup", price: 510, category: "Main courses"),
];

//menu window widget
class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //list of each section
      controller: ScrollController(),
      itemBuilder: (BuildContext context, int index) {
        return MenuSection(title: sections[index]);
      },
      itemCount: sections.length,
    );
  }
}

//menu section/category widget
class MenuSection extends StatefulWidget {
  final String title;

  const MenuSection({Key? key, required this.title}) : super(key: key);

  @override
  _MenuSectionState createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      fontWeight: FontWeight.bold, color: mainColor),
                )
              ],
            ),
          ),
          MenuSectionContent(
              // expanded content
              expanded: expandFlag,
              itemCount: products
                  .where((element) => element.category == widget.title)
                  .toList()
                  .length,
              child: ListView.builder(
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  List<ProductModel> items = products
                      .where((element) => element.category == widget.title)
                      .toList();

                  items.sort();
                  return MenuItem(
                    price: items[index].price,
                    name: items[index].name,
                    category: widget.title,
                  );
                },
                itemCount: products
                    .where((element) => element.category == widget.title)
                    .toList()
                    .length,
              ))
        ],
      ),
    );
  }
}

//Expanded content of a section
class MenuSectionContent extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  late final double expandedHeight;
  final Widget child;
  final int itemCount;

  MenuSectionContent(
      {Key? key,
      required this.child,
      required this.itemCount,
      this.collapsedHeight = 0.0,
      this.expanded = true})
      : super(key: key) {
    expandedHeight =
        min(expandedMaxHeight, itemCount * 50); //50 is the height of a MenuItem
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
class MenuItem extends StatelessWidget {
  final String name;
  final double price;
  final String category;

  const MenuItem({
    Key? key,
    required this.name,
    required this.price,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: accent1Color),
          color: accent2Color),
      child: ListTile(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(name),
          Text(price.toString()),
        ]),
        leading: Icon(
          sectionIcons[category],
          color: mainColor,
        ),
      ),
    );
  }
}
