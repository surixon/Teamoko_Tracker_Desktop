import 'package:intl/intl.dart';

class Utils{
  static String getFormattedDate(String date){
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  static String getCurrentFormattedDateTime(){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MMM-yy hh:mm');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getFormattedDateTimeFromTimeStamp(int timestamp){
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
    var formatter = new DateFormat('dd-MMM-yy hh:mm');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static int currentTimeInSeconds() {
    var ms = (new DateTime.now()).millisecond;
    return (ms / 1000).round();
  }
}