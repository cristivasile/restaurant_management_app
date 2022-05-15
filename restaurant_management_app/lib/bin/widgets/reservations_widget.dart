import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';
import 'package:restaurant_management_app/bin/entities/reservation_list.dart';
import 'package:restaurant_management_app/bin/models/reservation_model.dart';
import 'dart:math';

const double expandedMaxHeight = 400;
List<ReservationModel> reservations = ReservationList.getReservationList();

class ReservationsWidget extends StatefulWidget {
  const ReservationsWidget({Key? key}) : super(key: key);

  @override
  State<ReservationsWidget> createState() => _ReservationsWidgetState();
}

class _ReservationsWidgetState extends State<ReservationsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: ScrollController(),
        itemBuilder: (BuildContext context, int index) {
          return ReservationSection(
              title: reservations[index].tableId +
                  '\t' +
                  reservations[index].dateTime.toString() +
                  reservations[index].name,
              reservationModel: reservations[index]);
        },
        itemCount: reservations.length);
  }
}

class ReservationSection extends StatefulWidget {
  final String title;
  final ReservationModel reservationModel;

  const ReservationSection(
      {Key? key, required this.title, required this.reservationModel})
      : super(key: key);

  @override
  _ReservationSectionState createState() => _ReservationSectionState();
}

class _ReservationSectionState extends State<ReservationSection> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        child: Column(
          children: <Widget>[
            Container(
              color: accent1Color,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                            color: mainColor, shape: BoxShape.circle),
                        child: Center(
                          child: Icon(
                            expandFlag
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.amber,
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
                    widget.title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

// class ReservationSectionContent extends StatelessWidget {
//   final bool expanded;
//   final double collapsedHeight;
//   late final double expandedHeight;
//   final Widget child;
//   final int itemCount;

//   ReservationSectionContent(
//       {Key? key,
//       required this.child,
//       required this.itemCount,
//       this.collapsedHeight = 0.0,
//       this.expanded = true})
//       : super(key: key) {
//     expandedHeight = min(expandedMaxHeight, itemCount * 50);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       width: screenWidth,
//       height: expanded ? expandedHeight : collapsedHeight,
//       child: Container(
//         child: child,
//       ),
//     );
//   }
// }



