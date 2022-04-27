import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart' as constants;

//Movable table icon
class MovableTable extends StatefulWidget {
  final BoxConstraints constraints;
  const MovableTable({Key? key, required this.constraints}) : super(key: key);

  @override
  State<MovableTable> createState() => _MovableTableState();
}

class _MovableTableState extends State<MovableTable> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Draggable(
        feedback: Container(width: 100, height: 100, color: Colors.yellow),
        child: Container(width: 100, height: 100, color: Colors.blue),
        childWhenDragging:
            Container(width: 100, height: 100, color: Colors.green),
        onDragEnd: (DraggableDetails details) {
          setState(() {
            final adjustment = MediaQuery.of(context).size.height -
                widget.constraints.maxHeight;
            // details.offset is relative to the window instead of the container
            // => without this the item would be placed too low because of the app bar
            _offset = Offset(details.offset.dx, details.offset.dy - adjustment);
          });
        },
      ),
    );
  }
}
