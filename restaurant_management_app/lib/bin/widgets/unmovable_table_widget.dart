// ignore: file_names
import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart' as constants;

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
  late AssetImage _image = AssetImage("");
  // late UnmovableTableWidget? lastWidget = null;

  @override
  void initState() {
    super.initState();
    _position = widget.position;
    _image = AssetImage(widget.imagePath + ".png");
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
                      widget.imagePath + constants.feedbackPath + ".png")
                  : AssetImage(widget.imagePath + ".png"),
              width: widget._imageWidth.toDouble(),
              height: widget.imageHeight.toDouble(),
            ),
            Text(
              widget.id,
              style: TextStyle(
                  color:
                      (widget.id == selectedId) ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(onTap: () {
              setState(() {
                if (selectedId == "") {
                  selectedId = widget.id;
                } else if (selectedId == widget.id) {
                  selectedId = "";
                } else {
                  selectedId = widget.id;
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

// GestureDetector(
//   onTap: () => setState(() {
//     Image(
//         image: AssetImage(widget.imagePath + ".png"),
//         width: widget._imageWidth.toDouble(),
//         height: widget.imageHeight.toDouble());
//   }),
// ),

String getImagePath(int tableSize) {
  switch (tableSize) {
    case 2:
      return constants.twoTablePath;
    case 3:
      return constants.threeTablePath;
    case 4:
      return constants.fourTablePath;
    case 6:
      return constants.sixTablePath;
    case 8:
      return constants.eightTablePath;
  }

  throw Exception("Invalid table size!");
}

/// Receives a table size and returns a list containing the required dimensions
///
///@param tableSize: the size of the table
///@returns List<int> containing [0] = width and [1] = height
List<int> getImageSize(int tableSize) {
  const List<int> smallTable = [
    constants.smallTableWidth,
    constants.smallTableWidth
  ];
  const List<int> largeTable = [
    constants.largeTableWidth,
    constants.smallTableWidth
  ];

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
