import 'package:flutter/material.dart';
import 'package:na_todo/core/constants/color_constants.dart';
import 'package:na_todo/core/constants/general_functions.dart';

class DateTimePicker extends StatefulWidget {
  final void Function(DateTime) onDateSelected;
  final void Function(TimeOfDay) onTimeSelected;
  final TimeOfDay reminderTime;
  final DateTime reminderDate;

  const DateTimePicker({
    super.key,
    required this.onDateSelected,
    required this.onTimeSelected,
    required this.reminderDate,
    required this.reminderTime,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  String dateLabelVal = "";
  String timeLabelVal = "";

  @override
  void initState() {
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 8),
      decoration: BoxDecoration(
        color: ColorsConstants.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _datePicker(
            context: context,
          ),
          Container(
            height: 20,
            width: 2,
            color: ColorsConstants.greyColor,
          ),
          _timePicker(context: context),
        ],
      ),
    );
  }

  _datePicker({
    required BuildContext context,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          DateTime dateTime = (await showDatePicker(
                context: context,
                initialDate: widget.reminderDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 360)),
              ) ??
              DateTime.now());
          setState(() {
            dateLabelVal =
                GeneralFunctions.formatTimeStamp(timestamp: dateTime);
          });
          widget.onDateSelected(dateTime);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: ColorsConstants.darkGreyColor,
              ),
              SizedBox(
                width: 12,
              ),
              Text(dateLabelVal),
            ],
          ),
        ),
      ),
    );
  }

  _timePicker({required BuildContext context}) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          TimeOfDay timeVal = (await showTimePicker(
                context: context,
                initialTime: widget.reminderTime,
              ) ??
              TimeOfDay.now());
          setState(() {
            timeLabelVal = GeneralFunctions.formatTime(timeVal);
          });
          widget.onTimeSelected(timeVal);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time,
                color: ColorsConstants.darkGreyColor,
              ),
              SizedBox(
                width: 12,
              ),
              Text(timeLabelVal),
            ],
          ),
        ),
      ),
    );
  }

  void _setData() {
    setState(() {
      timeLabelVal = GeneralFunctions.formatTime(widget.reminderTime);
      dateLabelVal =
          GeneralFunctions.formatTimeStamp(timestamp: widget.reminderDate);
    });
  }
}
