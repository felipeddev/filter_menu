import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:filter_menu/main.dart';

void main() {
  String getDateTime() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    var now =  new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedDateTime = DateFormat.yMMMMEEEEd(Intl.systemLocale).format(now);
    return formattedDateTime;
  }

  debugPrint(getDateTime());
}