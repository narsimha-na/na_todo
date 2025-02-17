import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralFunctions {
  static formatTimeStamp({required DateTime timestamp}) {
    return (DateFormat.yMMMEd().format(timestamp));
  }

  static String formatTime(TimeOfDay timeVal) {
    return "${timeVal.hour} : ${timeVal.minute} ${timeVal.period.name.toString().toUpperCase()}";
  }
}
