// ignore: file_names
import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart' as constants;

import '../constants.dart';

/// Movable table object
///
class UnmovableTableWidget extends StatefulWidget {
  final String imagePath; //the corresponding table's image path
  final int _imageWidth; // width of the displayed image
  final int imageHeight; // height of the displayed image
  final int tableSize;
  final String id;
  final int floor;
  final Offset
      position; // position relative to the top left corner of the container
  final void Function() callback;
  UnmovableTableWidget({
    Key? key,
    required this.tableSize,
    required this.position,
    required this.id,
    required this.floor,
    required this.callback,
  })  : imagePath = getImagePath(tableSize),
        _imageWidth = getImageSize(tableSize)[0],
        imageHeight = getImageSize(tableSize)[1],
        super(key: key);

  @override
  State<UnmovableTableWidget> createState() => _UnmovableTableWidgetState();
}

class _UnmovableTableWidgetState extends State<UnmovableTableWidget> {
  static String selectedId = "";
  late Offset _position;

  @override
  void initState() {
    super.initState();
    _position = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: SizedBox(
        width: widget._imageWidth.toDouble(),
        height: widget.imageHeight.toDouble(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: (widget.id == selectedId)
                  ? AssetImage(
                      widget.imagePath + '_selected_highlighted' + ".png")
                  : AssetImage(widget.imagePath + ".png"),
              width: widget._imageWidth.toDouble(),
              height: widget.imageHeight.toDouble(),
            ),
            Text(
              widget.id,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(onTap: () {
              setState(() {
                if (selectedId == "") {
                  selectedId = widget.id;

                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                              title: const Text("Add new item",
                                  style: TextStyle(color: mainColor)),
                              content: SizedBox(
                                  height: 200,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        TextField(
                                            decoration: InputDecoration(
                                                hintText: "Enter table ID")),
                                        TextField(
                                            decoration: InputDecoration(
                                                hintText: "Enter order ID"))
                                      ])),
                              actions: [
                                TextButton(
                                    child: const Text('Add'), onPressed: () {}),
                                TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      selectedId = "";
                                      widget.callback();
                                    })
                              ]);
                        });
                      });
                } else if (selectedId == widget.id) {
                  selectedId = "";
                } else {
                  selectedId = widget.id;

                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                              title: const Text("Add new Reservation",
                                  style: TextStyle(color: mainColor)),
                              content: SizedBox(
                                  height: 200,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        TextField(
                                            decoration: InputDecoration(
                                                hintText: "Enter table ID")),
                                        TextField(
                                            decoration: InputDecoration(
                                                hintText: "Enter order ID"))
                                      ])),
                              actions: [
                                TextButton(
                                    child: const Text('Add'), onPressed: () {}),
                                TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      selectedId = "";
                                      widget.callback();
                                    })
                              ]);
                        });
                      });
                }
                widget.callback();
              });
            }),
          ],
        ),
      ),
    );
  }
}

/// Receives a table size and returns the path to the corresponding image
///
/// @param tableSize: size of the table
/// @note image paths are without extension
String getImagePath(int tableSize) {
  switch (tableSize) {
    case 2:
      return constants.AssetPaths.small2.value;
    case 3:
      return constants.AssetPaths.small3.value;
    case 4:
      return constants.AssetPaths.small4.value;
    case 6:
      return constants.AssetPaths.large6.value;
    case 8:
      return constants.AssetPaths.large8.value;
  }

  throw Exception("Invalid table size!");
}

/// Receives a table size and returns a list containing the required dimensions
///
///@param tableSize: the size of the table
///@returns List<int> containing [0] = width and [1] = height
List<int> getImageSize(int tableSize) {
  const List<int> smallTable = [constants.smallTblWidth, constants.tblHeight];
  const List<int> largeTable = [constants.largeTblWidth, constants.tblHeight];

  switch (tableSize) {
    case 2:
      return smallTable;
    case 3:
      return smallTable;
    case 4:
      return smallTable;
    case 6:
      return largeTable;
    case 8:
      return largeTable;
  }

  throw Exception("Invalid table size!");
}