import 'package:flutter/material.dart';

class DateButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const DateButton({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          primary: Colors.white,
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        onPressed: onClicked,
      );
}
