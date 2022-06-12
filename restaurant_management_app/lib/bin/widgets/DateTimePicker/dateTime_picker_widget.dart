import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_management_app/bin/widgets/DateTimePicker/date_button.dart';

class DatetimePickerWidget extends StatefulWidget {
  @override
  _DatetimePickerWidgetState createState() => _DatetimePickerWidgetState();

  DateTime _currentDate = DateTime.now();

  DateTime getInfo() {
    return _currentDate;
  }
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  @override
  Widget build(BuildContext context) => DateButton(
        text: getDateTime(),
        onClicked: () => pickDateTime(context),
      );

  Future<DateTime> pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget._currentDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate != null) {
      return newDate;
    } else {
      return widget._currentDate;
    }
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: widget._currentDate.hour,
            minute: widget._currentDate.minute));

    if (newTime != null) {
      return newTime;
    } else {
      return TimeOfDay(
          hour: widget._currentDate.hour, minute: widget._currentDate.minute);
    }
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);

    final time = await pickTime(context);

    setState(() {
      widget._currentDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getDateTime() {
    DateFormat dateFormat = DateFormat("MM/dd HH:mm");
    return dateFormat.format(widget._currentDate);
  }
}
