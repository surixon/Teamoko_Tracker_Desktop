import 'package:desk/base/base_view.dart';
import 'package:desk/components/edit_group_name_dialog.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/all_task_screen_arguments.dart';
import 'package:desk/model/chat_screen_arguments.dart';
import 'package:desk/model/our_task_screen_arguments.dart';
import 'package:desk/provider/group_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupListScreen extends StatefulWidget {
  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  GroupProvider _provider;

  String groupShortName(String groupName) {
    String shortName = groupName;

    if (groupName.length > 2 && (!groupName.contains(" "))) {
      shortName = groupName.substring(0, 2);
    } else if (groupName.length > 2 && (groupName.contains(" "))) {
      List<String> parts = groupName.split(" ");
      shortName = parts[0].substring(0, 1) + parts[1].substring(0, 1);
    }

    return shortName;
  }

  String setMemberName(String fullName) {
    List<String> parts = fullName.split(",");
    return parts[0] + " +" + (parts.length - 1).toString() + " more...";
  }


  void _deleteGroupAlert(String groupId, String groupName, int index) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        _provider.deleteGroup(context, groupId,index);
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
      title: Text("Delete?"),
      content: Text("Are you want to delete $groupName group?"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BaseView<GroupProvider>(
            onModelReady: (provider) {
              _provider=provider;
              provider.getGroupList(
                  context,
                  sharedPreferences.getString(userId),
                  sharedPreferences.getString(phoneNumber),
                  sharedPreferences.getString(companyId),
                  sharedPreferences.getString(userType),
                  '1',
                  '');
            },
            builder: (context, provider, _) =>Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 4.0,),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteConstants.new_group).then((value) {
                                _provider.getGroupList(
                                    context,
                                    sharedPreferences.getString(userId),
                                    sharedPreferences.getString(phoneNumber),
                                    sharedPreferences.getString(companyId),
                                    sharedPreferences.getString(userType),
                                    '1',
                                    '');
                            });
                          },
                          child: Row(
                            children: [
                              Image(
                                width: 40.0,
                                height: 40.0,
                                image:AssetImage("assets/images/ic_groupadd.png"),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "New Group",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13.0),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0,),
                    Expanded(
                        child: ListView.builder(
                            itemCount: provider.groupList.length,
                            itemBuilder: (context, int index) {
                              return Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all( Radius.circular(
                                          8)),
                                    ),
                                    elevation: 4,
                                    clipBehavior: Clip.none,
                                    child: Slidable(
                                      secondaryActions: <Widget>[

                                        IconSlideAction(
                                            icon: Icons.edit,
                                            color: Colors.black,
                                            caption: 'Edit',
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return EditGroupNameDialogBox(
                                                      provider: _provider,groupData: provider.groupList[index],index: index,);
                                                  });
                                            }),

                                        IconSlideAction(
                                            icon: Icons.delete,
                                            color: CommonColors.red,
                                            caption: 'Delete',
                                            onTap: () {
                                              _deleteGroupAlert(provider.groupList[index].groupId,provider.groupList[index].groupName,index);
                                            }),


                                      ],
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10.0, 8.0, 10.0, 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 48,
                                                      width: 48,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  24)),
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors.green,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      child: Center(
                                                        child: Text(
                                                          groupShortName(provider
                                                              .groupList[index]
                                                              .groupName),
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            provider
                                                                .groupList[index]
                                                                .groupName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color:
                                                                Colors.black,
                                                                fontSize: 16.0),
                                                            maxLines: 1,
                                                          ),
                                                          Text(
                                                            setMemberName(provider
                                                                .groupList[index]
                                                                .fullname),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color:
                                                                Colors.grey,
                                                                fontSize: 14.0),
                                                            maxLines: 1,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  RouteConstants
                                                                      .chat,
                                                                  arguments:
                                                                  ChatScreenArguments(
                                                                      '',
                                                                      '',
                                                                      '',
                                                                      '',
                                                                      ''));
                                                            },
                                                            child: Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .chat_bubble,
                                                                  color:
                                                                  Colors.grey,
                                                                  size: 17.0,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.0,
                                                                ),
                                                                provider
                                                                    .groupList[
                                                                index]
                                                                    .isSeen
                                                                    .isEmpty
                                                                    ? SizedBox()
                                                                    : provider.groupList[index]
                                                                    .isSeen ==
                                                                    '0'
                                                                    ? Icon(
                                                                  Icons
                                                                      .done,
                                                                  color:
                                                                  Colors.grey,
                                                                  size:
                                                                  17.0,
                                                                )
                                                                    : Icon(
                                                                  Icons
                                                                      .done_all,
                                                                  color:
                                                                  Colors.grey,
                                                                  size:
                                                                  17.0,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.0,
                                                                ),
                                                                provider
                                                                    .groupList[
                                                                index]
                                                                    .lastMsg
                                                                    .isNotEmpty
                                                                    ? Text(
                                                                  provider
                                                                      .groupList[
                                                                  index]
                                                                      .lastMsg,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .normal,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                      14.0),
                                                                  maxLines:
                                                                  1,
                                                                )
                                                                    : Text(
                                                                  'Chat now',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .normal,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                      14.0),
                                                                  maxLines:
                                                                  1,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                            width: 120.0,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: CommonColors.primaryColor,
                                                                border: Border
                                                                    .all(
                                                                  color:
                                                                  CommonColors
                                                                      .primaryColor,
                                                                ),
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        16))),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .fromLTRB(
                                                                  16.0,
                                                                  2.0,
                                                                  16.0,
                                                                  2.0),
                                                              child: Center(
                                                                  child:
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pushNamed(
                                                                          context,
                                                                          RouteConstants
                                                                              .add_task,
                                                                          arguments:
                                                                          '');
                                                                    },
                                                                    child: Text(
                                                                      'Add Task ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                  )),
                                                            )),
                                                        SizedBox(
                                                          height: 4.0,
                                                        ),
                                                        Container(
                                                          width: 120.0,
                                                          decoration:
                                                          BoxDecoration(
                                                              border:
                                                              Border.all(
                                                                color:
                                                                CommonColors
                                                                    .blue,
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  16))),
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .fromLTRB(
                                                                  16.0,
                                                                  2.0,
                                                                  16.0,
                                                                  2.0),
                                                              child:
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      RouteConstants
                                                                          .all_task,
                                                                      arguments:
                                                                      AllTaskScreenArguments(
                                                                          '',
                                                                          '',
                                                                          '',
                                                                          ''));
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                          'All Tasks ',
                                                                          style: TextStyle(
                                                                              color:
                                                                              Colors.black)),
                                                                    ),
                                                                    Text(
                                                                        provider
                                                                            .groupList[
                                                                        index]
                                                                            .receivedTask,
                                                                        style: TextStyle(
                                                                            color:
                                                                            Colors.black)),
                                                                  ],
                                                                ),
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          height: 4.0,
                                                        ),
                                                        Container(
                                                            width: 120.0,
                                                            decoration:
                                                            BoxDecoration(
                                                                border: Border
                                                                    .all(
                                                                  color: CommonColors
                                                                      .green,
                                                                ),
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        16))),
                                                            child: Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                    16.0,
                                                                    2.0,
                                                                    16.0,
                                                                    2.0),
                                                                child:
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        RouteConstants
                                                                            .our_task,
                                                                        arguments: OurTaskScreenArguments(
                                                                            '',
                                                                            provider
                                                                                .groupList[
                                                                            index]
                                                                                .groupName,
                                                                            '10',
                                                                            provider
                                                                                .groupList[index]
                                                                                .groupId));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Text(
                                                                            'Our Tasks ',
                                                                            style:
                                                                            TextStyle(color: Colors.black)),
                                                                      ),
                                                                      Text(
                                                                          provider
                                                                              .groupList[
                                                                          index]
                                                                              .totalTask,
                                                                          style: TextStyle(
                                                                              color:
                                                                              Colors.black))
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
                                    height: 8.0,
                                  ),
                                ],
                              );
                            })),
                  ],
                ),
                Center(
                  child: provider.state == ViewState.Busy
                      ? CircularProgressIndicator()
                      : Container(),
                ),
              ],
            )));
  }
}