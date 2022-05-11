import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/services/product_service.dart';
import 'package:restaurant_management_app/bin/widgets/custom_button.dart';
import 'dart:math';

import '../entities/product_list.dart';
import '../models/product_model.dart';

const double expandedMaxHeight = 400;

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
  bool _expandFlag = false;
  String _errorMessage = "";
  List<ProductModel> _products = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController  = TextEditingController();

  @override
  void initState() {
    super.initState();
    _products = ProductList.getProductList();
  }

  @override
  void dispose(){
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget> [
          Container(
            // top bar containing title and expand button
            color: accent1Color,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
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
                            _expandFlag
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _expandFlag = !_expandFlag;
                        });
                      }),
                    IconButton(
                      // expand button
                      icon: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                          color: mainColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      onPressed: () async {

                        setState(() {
                          _expandFlag = true;
                        });

                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return StatefulBuilder(
                              builder: (context, setState) {
                              return AlertDialog(
                                title: const Text("Add new item", style: TextStyle(color: mainColor),),
                                content: 
                                  SizedBox(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      TextField(decoration: const InputDecoration(hintText: "Enter product name"), controller: nameController,),
                                      TextField(decoration: const InputDecoration(hintText: "Enter price"), controller: priceController,),
                                      Text(_errorMessage, style: const TextStyle(color: Colors.redAccent),),
                                    ],),
                                  ),
                                
                                actions: [
                                  TextButton(child: const Text('Add'),
                                  onPressed: () {

                                    setState(() {
                                      _errorMessage = "";
                                    });

                                    String name = nameController.text.trim();

                                    if(name.length < 3){
                                      setState(() {
                                        _errorMessage = "Product name must have at least 3 characters!";
                                      });
                                      return;
                                    }

                                    if(name.length > 20){
                                      setState(() {
                                        _errorMessage = "Product name must have at most 20 characters!";
                                      });
                                      return;
                                    }

                                    for(var product in ProductList.getProductList()){
                                      if(name.toLowerCase() == product.name.toLowerCase()){
                                        setState(() {
                                        _errorMessage = "Product name already exists!";
                                      });
                                      return;
                                      }
                                    }

                                    double? price = double.tryParse(priceController.text);

                                    if(price == null || price <= 0) {
                                      setState(() {
                                        _errorMessage = "Incorrect price! Must be a number higher than 0.";
                                      });
                                      return;
                                    }

                                    createProduct(name, price, widget.title);
                                  }, style: TextButton.styleFrom(primary: mainColor),),
                                  TextButton(child: const Text('Cancel'),
                                  onPressed: () {Navigator.of(context).pop();}, style: TextButton.styleFrom(primary: mainColor),),
                                ],
                              );
                              }
                            );}
                        );
                      }),
                  ],
                ),
                Text(
                  // Section title
                  widget.title.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: mainColor),
                )
              ],
            ),
          ),
          MenuSectionContent(
              // expanded content
              expanded: _expandFlag,
              itemCount: _products
                  .where((element) => element.category == widget.title)
                  .toList()
                  .length,
              child: ListView.builder(
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  List<ProductModel> items = _products
                      .where((element) => element.category == widget.title)
                      .toList();

                  items.sort();
                  return MenuItem(
                    price: items[index].price,
                    name: items[index].name,
                    category: widget.title,
                    function: deleteProductByName,
                  );
                },
                itemCount: _products
                    .where((element) => element.category == widget.title)
                    .toList()
                    .length,
              ))
        ],
      ),
    );
  }

  void createProduct(String name, double price, String category){
    ProductModel newProduct = ProductModel(name: name, price: price, category: category);
    ProductList.addProduct(newProduct);
    
    setState(() {
      _products = ProductList.getProductList();
    });

    saveProducts();
  }

  void deleteProductByName(String name){
    ProductList.removeProductByName(name);

    setState(() {
      _products = ProductList.getProductList();
    });
    
    saveProducts();
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
  final void Function(String) function;

  const MenuItem({
    Key? key,
    required this.name,
    required this.price,
    required this.category,
    required this.function,
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
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Text(price.toString())),
                CustomButton(color: Colors.red, function: () {function(name);}, size: 25, icon: const Icon(Icons.delete)),
              ],
            ),
        ]),
        leading: Icon(
          sectionIcons[category],
          color: mainColor,
        ),
      ),
    );
  }
}
