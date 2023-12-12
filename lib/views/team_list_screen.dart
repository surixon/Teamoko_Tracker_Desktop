import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/all_task_screen_arguments.dart';
import 'package:desk/model/chat_screen_arguments.dart';
import 'package:desk/model/our_task_screen_arguments.dart';
import 'package:desk/provider/team_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamListScreen extends StatefulWidget {
  @override
  _TeamListScreenState createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  TeamProvider _provider;

  String adminType(String userType) {
    if (userType == '2') {
      return '';
    } else if (userType == '3') {
      return 'Admin';
    } else if (userType == '4') {
      return 'Super Admin';
    }
    return '';
  }

  IconSlideAction adminStatus(String userId, String userType) {
    if (userType == '2') {
      return IconSlideAction(
          icon: Icons.cancel,
          caption: 'Make Admin',
          color: CommonColors.primaryColor,
          onTap: () {
            _makeRemoveAdmin(
                userId, userType, 'Make Admin', "Do you want to make admin ?");
          });
    } else if (userType == '3') {
      return IconSlideAction(
          icon: Icons.cancel,
          caption: 'Remove Admin',
          color: CommonColors.primaryColor,
          onTap: () {
            _makeRemoveAdmin(userId, userType, 'Remove Admin',
                'Do you want to remove admin ?');
          });
    } else if (userType == '4') {
      return null;
    }
  }

  void _holdDialog(String userId) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        _provider.blockUnblock(context, userId, '1');
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
      title: Text("Hold ?"),
      content: Text("Do you want to hold?"),
      actions: [ cancelButton,okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _makeRemoveAdmin(
      String userId, String userType, String title, String description) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        if (userType == '2') {
          _provider.addRemoveAdmin(context, userId, '3');
        } else if (userType == "3") {
          _provider.addRemoveAdmin(context, userId, '2');
        }
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
      title: Text(title),
      content: Text(description),
      actions: [ cancelButton,okButton],
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BaseView<TeamProvider>(
          onModelReady: (provider) {
            _provider = provider;
            provider.getTeamList(
                context,
                sharedPreferences.getString(userId),
                sharedPreferences.getString(phoneNumber),
                sharedPreferences.getString(companyId),
                sharedPreferences.getString(userType),
                '0',
                '');
          },
          builder: (context, provider, _) => Stack(children: [
            Center(
              child: provider.state == ViewState.Busy
                  ? CircularProgressIndicator()
                  : Container(),
            ),
            ListView.builder(
                itemCount: provider.teamList.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        elevation: 4,
                        clipBehavior: Clip.none,
                        child: Slidable(
                          actions: <Widget>[
                            adminStatus(provider.teamList[index].userId,
                                provider.teamList[index].userType),
                            IconSlideAction(
                                icon: Icons.person_remove,
                                caption: 'Hold',
                                color: Colors.black,
                                onTap: () {
                                  _holdDialog(provider.teamList[index].userId);
                                }),
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                                icon: Icons.perm_identity_sharp,
                                color: Colors.black,
                                caption: 'Logs',
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteConstants.logs,
                                      arguments:
                                          provider.teamList[index].userId);
                                }),
                            IconSlideAction(
                                icon: Icons.remove_red_eye_outlined,
                                color: CommonColors.primaryColor,
                                caption: 'Screen Tracker',
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteConstants.screen_tracker,
                                      arguments:
                                          provider.teamList[index].userId);
                                }),
                            IconSlideAction(
                                icon: Icons.done,
                                color: CommonColors.blue,
                                caption: 'Done Task',
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteConstants.our_done_task,
                                      arguments: OurTaskScreenArguments(
                                          provider.teamList[index].userId,
                                          provider.teamList[index].name,
                                          '10',
                                          ''));
                                }),
                          ],
                          child: Column(
                            children: <Widget>[
                              Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        2.0, 2.0, 2.0, 2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                adminType(_provider
                                                    .teamList[index].userType),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 13.0),
                                                maxLines: 1,
                                              ),
                                              SizedBox(
                                                height: 2.0,
                                              ),
                                              CircleAvatar(
                                                radius: 24,
                                                backgroundImage: NetworkImage(
                                                    provider.teamList[index]
                                                        .ppThumbnail),
                                              ),
                                              SizedBox(
                                                height: 2.0,
                                              ),
                                              Text(
                                                provider.teamList[index]
                                                    .workingHours,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 11.0),
                                                maxLines: 1,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider.teamList[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                maxLines: 1,
                                              ),
                                              Text(
                                                provider.teamList[index]
                                                    .designation,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                                maxLines: 1,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      RouteConstants.chat,
                                                      arguments:
                                                          ChatScreenArguments(
                                                              provider
                                                                  .teamList[
                                                                      index]
                                                                  .userId,
                                                              provider
                                                                  .teamList[
                                                                      index]
                                                                  .contact,
                                                              provider
                                                                  .teamList[
                                                                      index]
                                                                  .ppThumbnail,
                                                              provider
                                                                  .teamList[
                                                                      index]
                                                                  .name,
                                                              ''));
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.chat_bubble,
                                                      color: Colors.grey,
                                                      size: 17.0,
                                                    ),
                                                    SizedBox(
                                                      width: 2.0,
                                                    ),
                                                    provider.teamList[index]
                                                            .isSeen.isEmpty
                                                        ? SizedBox()
                                                        : provider
                                                                    .teamList[
                                                                        index]
                                                                    .isSeen ==
                                                                '0'
                                                            ? Icon(
                                                                Icons.done,
                                                                color:
                                                                    Colors.grey,
                                                                size: 17.0,
                                                              )
                                                            : Icon(
                                                                Icons.done_all,
                                                                color:
                                                                    Colors.grey,
                                                                size: 17.0,
                                                              ),
                                                    SizedBox(
                                                      width: 2.0,
                                                    ),
                                                    Expanded(
                                                      child: provider
                                                              .teamList[index]
                                                              .lastMsg
                                                              .isNotEmpty
                                                          ? Text(
                                                              provider
                                                                  .teamList[
                                                                      index]
                                                                  .lastMsg,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14.0),
                                                              maxLines: 1,
                                                            )
                                                          : Text(
                                                              'Chat now',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14.0),
                                                              maxLines: 1,
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                                width: 120.0,
                                                decoration: BoxDecoration(
                                                  color: CommonColors.primaryColor,
                                                    border: Border.all(
                                                      color: CommonColors.primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      16.0, 2.0, 16.0, 2.0),
                                                  child: Center(
                                                      child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteConstants
                                                              .add_task,
                                                          arguments: '');
                                                    },
                                                    child: Text(
                                                      'Add Task ',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                                )),
                                            SizedBox(
                                              height: 4.0,
                                            ),
                                            Container(
                                              width: 120.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: CommonColors.blue,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16))),
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      16.0, 2.0, 16.0, 2.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteConstants
                                                              .all_task,
                                                          arguments:
                                                              AllTaskScreenArguments(
                                                                  provider
                                                                      .teamList[
                                                                          index]
                                                                      .userId,
                                                                  provider
                                                                      .teamList[
                                                                          index]
                                                                      .name,
                                                                  provider
                                                                      .teamList[
                                                                          index]
                                                                      .contact,
                                                                  '0'));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                              'All Tasks ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                        Text(
                                                            provider
                                                                .teamList[index]
                                                                .receivedTask,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 4.0,
                                            ),
                                            Container(
                                                width: 120.0,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: CommonColors.green,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16.0,
                                                            2.0,
                                                            16.0,
                                                            2.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteConstants
                                                                .our_task,
                                                            arguments: OurTaskScreenArguments(
                                                                provider
                                                                    .teamList[
                                                                        index]
                                                                    .userId,
                                                                provider
                                                                    .teamList[
                                                                        index]
                                                                    .name,
                                                                '10',
                                                                ''));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                                'Our Tasks ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                          Text(
                                                              provider
                                                                  .teamList[
                                                                      index]
                                                                  .totalTask,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black))
                                                        ],
                                                      ),
                                                    ))),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          actionPane: SlidableDrawerActionPane(),
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                    ],
                  );
                })
          ]),
        ));
  }
}
