import 'package:desk/data/socket_io_manager.dart';
import 'package:desk/enum/attendence_type.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TimeTracking extends StatefulWidget {
  @override
  _TimeTrackingState createState() => _TimeTrackingState();
}

class _TimeTrackingState extends State<TimeTracking> {
  bool status = false;
  AttendenceType _attendenceType;
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  SocketIoManager socketIoManager = GetIt.instance.get();
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      _handleAttendenceTurnOff(true);
    } else {
      _handleAttendenceTurnOff(false);
    }
  }

  void updateAttendanceStatus(String attendanceType, bool attendanceStatus) {
    // attendanceType 0 for base and 1 for location
    // attendanceStatus 0 for off and 1 for on
    var data = {
      "company_id": _sharedPreferences.getString(companyId),
      "attendanceType": attendanceType,
      "attendanceStatus": attendanceStatus ? '1' : '0',
    };

    socketIoManager.socket.emit("updateAttendanceStatus", data);
    print("Attendance Status Emit  " + data.toString());
  }

  void _handleAttendenceTurnOff(bool enable) {
    Widget okButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          isSwitched = enable;
          _sharedPreferences.setBool(iSAttendence, isSwitched);
          updateAttendanceStatus("0", enable);
        });
      },
    );
    Widget cancelButton = TextButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Alert'),
      content: !enable
          ? Text('Do you want turn off attendance feature ?')
          : Text('Do you want turn on attendance feature ?'),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _infoAlert(String title, String description) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    isSwitched = _sharedPreferences.getBool(iSAttendence);

    if (_sharedPreferences.getString(attendenceType) == ("0")) {
      _attendenceType = AttendenceType.basicMannual;
    } else if (_sharedPreferences.getString(attendenceType) == ("1")) {
      _attendenceType = AttendenceType.locationBased;
    } else if (_sharedPreferences.getString(attendenceType) == ("2")) {
      _attendenceType = AttendenceType.locationBasedAutomatic;
    } else if (_sharedPreferences.getString(attendenceType) == ("3")) {
      _attendenceType = AttendenceType.screenTracker;
    }

  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Time Tracking",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Tracking',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Switch(
                    onChanged: toggleSwitch,
                    value: isSwitched,
                    activeColor: CommonColors.primaryColor,
                    activeTrackColor:
                    MaterialColor(0xFFf3396a, CommonColors.color)
                        .shade200,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            ListTile(
              title: const Text('Screen Tracker',style: TextStyle(color: Colors.black)),
              leading: Radio(
                value: AttendenceType.screenTracker,
                groupValue: _attendenceType,
                onChanged: (AttendenceType value) {
                  setState(() {
                    _attendenceType = value;
                    updateAttendanceStatus("3", true);
                  });
                },
                activeColor:  MaterialColor(0xFFf3396a, CommonColors.color),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.help,
                  color: CommonColors.primaryColor,
                ),
                onPressed: () {
                  _infoAlert('Tracker', 'Team Check-In/Out with tracker app.');
                },
              ),
            ),
            ListTile(
              title: const Text('Basic Mannual',style: TextStyle(color: Colors.black)),
              leading: Radio(
                value: AttendenceType.basicMannual,
                activeColor:  MaterialColor(0xFFf3396a, CommonColors.color),
                groupValue: _attendenceType,
                onChanged: (AttendenceType value) {
                  setState(() {
                    _attendenceType = value;
                    updateAttendanceStatus("0", true);
                  });
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.help,
                  color: CommonColors.primaryColor,
                ),
                onPressed: () {
                  _infoAlert(
                      'Basic Mannual', 'Check-In/Out without location needed.');
                },
              ),
            ),
            ListTile(
              title: const Text('Location Based Mannual',style: TextStyle(color: Colors.black),),
              leading: Radio(
                activeColor:  MaterialColor(0xFFf3396a, CommonColors.color),
                value: AttendenceType.locationBased,
                groupValue: _attendenceType,
                onChanged: (AttendenceType value) {
                  setState(() {
                    _attendenceType = value;
                    updateAttendanceStatus("1", true);
                  });
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.help,
                  color: CommonColors.primaryColor,
                ),
                onPressed: () {
                  _infoAlert('Location Based Mannual',
                      'Check-In/Out based on location.');
                },
              ),
            ),
            ListTile(
              title: const Text('Location Based Automatic Beta',style: TextStyle(color: Colors.black)),
              leading: Radio(
                value: AttendenceType.locationBasedAutomatic,
                groupValue: _attendenceType,
                activeColor:  MaterialColor(0xFFf3396a, CommonColors.color),
                onChanged: (AttendenceType value) {
                  setState(() {
                    _attendenceType = value;
                    updateAttendanceStatus("2", true);
                  });
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.help,
                  color: CommonColors.primaryColor,
                ),
                onPressed: () {
                  _infoAlert('Location Based Automatic Beta',
                      'Automatic Check-In/Out.');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
