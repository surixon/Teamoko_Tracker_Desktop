import 'package:desk/base/base_view.dart';
import 'package:desk/components/check_out_dialog.dart';
import 'package:desk/components/nav_button.dart';
import 'package:desk/data/socket_io_manager.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/main_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/layout_size.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:desk/views/done_task.dart';
import 'package:desk/views/report.dart';
import 'package:desk/views/self_task_screen.dart';
import 'package:desk/views/settings.dart';
import 'package:desk/views/support.dart';
import 'package:desk/views/task_screen.dart';
import 'package:desk/views/team_list_main_screen.dart';
import 'package:desk/views/time_tracking.dart';
import 'package:desk/views/upgrade_membership.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'invite_team_members.dart';
import 'my_logs.dart';
import 'my_report.dart';
import 'my_screen_tracker.dart';

class MainScaffold extends StatefulWidget {
  MainScaffold({Key key}) : super(key: key);

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  SocketIoManager socketIoManager = GetIt.instance.get();
  MainProvider _provider;
  int _selectedIndex = 0;
  final padding = 8.0;
  final _isHours = true;
  static String totalMembers = '';

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
  );

  List<Widget> screens = [
    TeamListMainScreen(),
    TaskScreen(),
    DoneTaskScreen(),
    SelfTaskScreen(),
    InviteTeamMembers(),
    TimeTracking(),
    DailyReport(),
    Logs(),
    MyScreenTracking(),
    UpgradeMembership(),
    Report(),
    Settings(),
    Support(),
  ];

  List<Widget> employeeScreens = [
    TeamListMainScreen(),
    TaskScreen(),
    DoneTaskScreen(),
    SelfTaskScreen(),
    DailyReport(),
    Logs(),
    MyScreenTracking(),
    Settings(),
    Support(),
  ];

  List<NavigationRailDestination> superAdminOption = [
    NavButton(
        label: "Team",
        iconPath: 'assets/images/ic_team.png',
        counter: totalMembers),
    NavButton(label: "Tasks", iconPath: 'assets/images/ic_task.png'),
    NavButton(label: "Done", iconPath: 'assets/images/ic_done.png'),
    NavButton(label: "My Self", iconPath: 'assets/images/ic_self.png'),
    NavButton(
        label: "Invite Team Members",
        iconPath: 'assets/images/ic_invite_member.png'),
    NavButton(
        label: "Time Tracking", iconPath: 'assets/images/ic_tracking.png'),
    NavButton(label: "My Report", iconPath: 'assets/images/ic_report.png'),
    NavButton(label: "My Logs", iconPath: 'assets/images/ic_view_logs.png'),
    NavButton(
        label: "My Screen Tracking", iconPath: 'assets/images/ic_tracking.png'),
    NavButton(label: "Upgrade", iconPath: 'assets/images/ic_upgrade.png'),
    NavButton(label: "Report", iconPath: 'assets/images/ic_icon_report.png'),
    NavButton(label: "Settings", iconPath: 'assets/images/ic_setting.png'),
    NavButton(
        label: "Report an issuse/feedback",
        iconPath: 'assets/images/ic_support.png'),
    NavButton(label: "Logout", iconPath: 'assets/images/ic_logout.png'),
  ];

  List<NavigationRailDestination> subAdminOption = [
    NavButton(label: "Team", iconPath: 'assets/images/ic_team.png'),
    NavButton(label: "Tasks", iconPath: 'assets/images/ic_task.png'),
    NavButton(label: "Done", iconPath: 'assets/images/ic_done.png'),
    NavButton(label: "My Self", iconPath: 'assets/images/ic_self.png'),
    NavButton(
        label: "Invite Team Members",
        iconPath: 'assets/images/ic_invite_member.png'),
    NavButton(
        label: "Time Tracking", iconPath: 'assets/images/ic_tracking.png'),
    NavButton(label: "My Report", iconPath: 'assets/images/ic_report.png'),
    NavButton(label: "My Logs", iconPath: 'assets/images/ic_view_logs.png'),
    NavButton(
        label: "My Screen Tracking", iconPath: 'assets/images/ic_tracking.png'),
    NavButton(label: "Report", iconPath: 'assets/images/ic_icon_report.png'),
    NavButton(label: "Settings", iconPath: 'assets/images/ic_setting.png'),
    NavButton(
        label: "Report an issuse/feedback",
        iconPath: 'assets/images/ic_support.png'),
    NavButton(label: "Logout", iconPath: 'assets/images/ic_logout.png'),
  ];
  List<NavigationRailDestination> employeeOption = [
    NavButton(label: "Team", iconPath: 'assets/images/ic_team.png'),
    NavButton(label: "Tasks", iconPath: 'assets/images/ic_task.png'),
    NavButton(label: "Done", iconPath: 'assets/images/ic_done.png'),
    NavButton(label: "My Self", iconPath: 'assets/images/ic_self.png'),
    NavButton(label: "My Report", iconPath: 'assets/images/ic_report.png'),
    NavButton(label: "My Logs", iconPath: 'assets/images/ic_view_logs.png'),
    NavButton(
        label: "My Screen Tracking", iconPath: 'assets/images/ic_tracking.png'),
    NavButton(label: "Settings", iconPath: 'assets/images/ic_setting.png'),
    NavButton(
        label: "Report an issuse/feedback",
        iconPath: 'assets/images/ic_support.png'),
    NavButton(label: "Logout", iconPath: 'assets/images/ic_logout.png'),
  ];

  void _handleLogout() {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        _provider.logout(context, _sharedPreferences.getString(userId), "");
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
      title: Text("Sign Out?"),
      content: Text("Are you sure you want to sign-out?"),
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

  void _handleCheckIn() {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        _provider.attendence(_scaffoldKey.currentContext, '1');
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
      title: Text("Check In"),
      content: Text("Do you want to check In for today?"),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<NavigationRailDestination> destinationByUserType() {
    if (_sharedPreferences.getString(userType) == '4') {
      print("TotalMemberss " + totalMembers);
      return superAdminOption;
    } else if (_sharedPreferences.getString(userType) == '3') {
      return subAdminOption;
    } else {
      return employeeOption;
    }
  }

  List<Widget> screenByUserType() {
    if (_sharedPreferences.getString(userType) == '4') {
      return screens;
    } else if (_sharedPreferences.getString(userType) == '3') {
      return screens;
    } else {
      return employeeScreens;
    }
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    socketIoManager.socket
        .emit('onlineuser', {'user_id': _sharedPreferences.getString(userId)});
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LayoutSize.init(context);
    return Scaffold(
      key: _scaffoldKey,
      /* endDrawer: !LayoutSize.isLarge ? TaskDetailScreen() : Container(),*/
      backgroundColor: Color(0xff28292E),
      body: BaseView<MainProvider>(
          onModelReady: (provider) {
            _provider = provider;
            _provider.getProfile(context).then((value) {
              if (value != null && value) {
                if (_provider.profileResponse.response.data.checkIn == '1') {
                  List<String> workingHours = _provider
                      .profileResponse.response.data.workingHours
                      .split(":");
                  Duration fastestMarathon = new Duration(
                      hours: int.parse(workingHours[0]),
                      minutes: int.parse(workingHours[1]),
                      seconds: 0);

                  _stopWatchTimer
                      .setPresetSecondTime(fastestMarathon.inSeconds);
                 // _stopWatchTimer.onExecute.add(StopWatchExecute.start);

                  setState(() {
                    totalMembers =
                        _provider.profileResponse.response.data.totalMembers;
                  });
                }

                if (_provider.profileResponse.response.data.attendanceStatus ==
                    ("0")) {
                  _sharedPreferences.setBool(iSAttendence, false);
                } else {
                  _sharedPreferences.setBool(iSAttendence, true);
                }

                _sharedPreferences.setString(attendenceType, _provider.profileResponse.response.data.attendanceType);
              }
            });
          },
          builder: (context, provider, _) => Row(
                children: <Widget>[
                  LayoutBuilder(
                    builder: (context, constraint) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraint.maxHeight),
                          child: IntrinsicHeight(
                            child: NavigationRail(
                              minWidth: 40.0,
                              groupAlignment: -1.0,
                              backgroundColor: Colors.white,
                              selectedIndex: _selectedIndex,
                              minExtendedWidth: 240.0,
                              extended: !LayoutSize.isSmall,
                              onDestinationSelected: (int index) {
                                setState(() {
                                  if (_sharedPreferences.getString(userType) ==
                                          '4' &&
                                      index == 13) {
                                    _handleLogout();
                                  } else if (_sharedPreferences
                                              .getString(userType) ==
                                          '4' &&
                                      index == 9) {
                                    _launchInWebViewWithJavaScript(
                                        'https://teamoko.com/Login/members?user_id=' +
                                            _sharedPreferences
                                                .getString(userId));
                                  } else if (_sharedPreferences
                                              .getString(userType) ==
                                          '3' &&
                                      index == 13) {
                                    _handleLogout();
                                  } else if (_sharedPreferences
                                              .getString(userType) ==
                                          '2' &&
                                      index == 9) {
                                    _handleLogout();
                                  } else {
                                    _selectedIndex = index;
                                  }
                                });
                              },
                              labelType: NavigationRailLabelType.none,
                              leading: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteConstants.profile);
                                    },
                                    child: (_provider.profileResponse == null ||
                                            _provider.profileResponse.response
                                                .data.ppThumbnail.isEmpty)
                                        ? CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                CommonColors.primaryColor,
                                          )
                                        : CircleAvatar(
                                            radius: 24,
                                            backgroundImage: NetworkImage(
                                                _provider
                                                    .profileResponse
                                                    .response
                                                    .data
                                                    .ppThumbnail)),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _provider.profileResponse == null
                                            ? ''
                                            : _provider.profileResponse.response
                                                    .data.companyName ??
                                                '',
                                        style: TextStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        _provider.profileResponse == null
                                            ? ''
                                            : _provider.profileResponse.response
                                                    .data.fullname ??
                                                '',
                                        style: TextStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 11),
                                      ),
                                      Text(
                                        _provider.profileResponse == null
                                            ? ''
                                            : _provider.profileResponse.response
                                                    .data.contact ??
                                                '',
                                        style: TextStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 11),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (_provider.profileResponse.response
                                                  .data.attendanceStatus ==
                                              '0') {
                                            DialogHelper.showMessage(context,
                                                'Your time tracking is turned off by admin.');
                                          } else if (_provider
                                                  .profileResponse
                                                  .response
                                                  .data
                                                  .attendanceStatus ==
                                              '3') {
                                            DialogHelper.showMessage(context,
                                                'Your team is doing Check-In/Out with tracker app.');
                                          } else {
                                            _provider.profileResponse.response
                                                        .data.checkIn ==
                                                    '1'
                                                ? showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CheckOutDialogBox(
                                                        provider: _provider,
                                                        c: _scaffoldKey
                                                            .currentContext,
                                                      );
                                                    })
                                                : _handleCheckIn();
                                          }
                                        },
                                        child: Wrap(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      CommonColors.primaryColor,
                                                  border: Border.all(
                                                    color: CommonColors
                                                        .primaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Center(
                                                    child: _checkInOut(),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: StreamBuilder<int>(
                                          stream: _stopWatchTimer.rawTime,
                                          initialData:
                                              _stopWatchTimer.rawTime.value,
                                          builder: (context, snap) {
                                            final value = snap.data;
                                            final displayTime =
                                                StopWatchTimer.getDisplayTime(
                                                    value,
                                                    hours: _isHours,
                                                    milliSecond: false,
                                                    second: false);
                                            return Column(
                                              children: <Widget>[
                                                Text(
                                                  displayTime,
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: CommonColors
                                                          .primaryColor),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteConstants.profile);
                                        },
                                        child: (_provider.profileResponse ==
                                                    null ||
                                                _provider
                                                    .profileResponse
                                                    .response
                                                    .data
                                                    .coverPic
                                                    .isEmpty)
                                            ? CircleAvatar(
                                                radius: 16,
                                                backgroundColor:
                                                    CommonColors.primaryColor,
                                              )
                                            : CircleAvatar(
                                                radius: 16,
                                                backgroundImage: NetworkImage(
                                                    _provider
                                                        .profileResponse
                                                        .response
                                                        .data
                                                        .coverPic)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              selectedLabelTextStyle: TextStyle(
                                color: MaterialColor(
                                    0xFFf3396a, CommonColors.color),
                                fontSize: 13,
                                letterSpacing: 0.8,
                                decorationThickness: 2.0,
                              ),
                              unselectedLabelTextStyle: TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 0.8,
                                  color: Colors.grey),
                              destinations: destinationByUserType(),
                              unselectedIconTheme: IconThemeData(
                                  color: Colors.grey, opacity: 1.0, size: 24.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

//VerticalDivider(thickness: 1, width: 1),
// This is the main content.
                  Expanded(
                      child: Stack(
                    children: [
                      screenByUserType()[_selectedIndex],
                      _provider.state == ViewState.Busy
                          ? Center(
                              child: /*CircularProgressIndicator()*/
                                  Container(),
                            )
                          : Container(),
                    ],
                  )),
                  LayoutSize.isLarge
                      ? const VerticalDivider(width: 0)
                      : Container(),
/*  LayoutSize.isLarge ? TaskDetailScreen() : Container()*/
                ],
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, RouteConstants.add_task, arguments: '');
/* FilePickerCross myFile = await FilePickerCross.importFromStorage(
              type: FileTypeCross.any,       // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
              fileExtension: 'txt, md'     // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
          );*/
        },
        elevation: 0.0,
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: CommonColors.primaryColor,
      ),
    );
  }

  Text _checkInOut() {
    if (_provider.profileResponse == null) {
      return Text('');
    }

    if (_provider.profileResponse.response.data.checkIn == '1') {
      List<String> workingHours =
          _provider.profileResponse.response.data.workingHours.split(":");
      Duration fastestMarathon = new Duration(
          hours: int.parse(workingHours[0]),
          minutes: int.parse(workingHours[1]),
          seconds: 0);

      _stopWatchTimer.setPresetSecondTime(fastestMarathon.inSeconds);

      //_stopWatchTimer.onExecute.add(StopWatchExecute.start);
    } else if (_provider.profileResponse.response.data.checkIn == '2') {
      if (_stopWatchTimer.isRunning) {
        //_stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      }
    }

    return _provider.profileResponse.response.data.checkIn == '1'
        ? Text(
            'Check Out',
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )
        : Text('Check In',
            style: TextStyle(fontSize: 12.0, color: Colors.white));
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}
