// @dart=2.9
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:desk/base/base_view.dart';
import 'package:desk/components/task_reason_alert.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/chat_screen_arguments.dart';
import 'package:desk/model/task_detail_response.dart';
import 'package:desk/provider/tasks_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:desk/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetailScreen extends StatefulWidget {
  var arguments;

  TaskDetailScreen({this.arguments});

  TaskDetailScreenState createState() => TaskDetailScreenState();
}

class TaskDetailScreenState extends State<TaskDetailScreen> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  ScreenScaler scaler;
  final _titleTextEdit = TextEditingController();
  final _descriptionEdit = TextEditingController();
  var eventStaus;
  var eventUserId;
  var isEdittable = false;
  TaskProvider _provider;
  String priority;
  String taskTime;
  String taskDate;

  Text _setToUserName(TaskDetailData taskDetail) {
    if (taskDetail.isGroupchat == "1") {
      if (taskDetail.userId == sharedPreferences.getString(userId)) {
        return Text(sharedPreferences.getString(userName),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskDetail.groupName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskDetail.userId == sharedPreferences.getString(userId)) {
        return Text(taskDetail.toUser ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskDetail.userName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    }
  }

  Text _setFromUserName(TaskDetailData taskDetail) {
    if (taskDetail.isGroupchat == "1") {
      if (taskDetail.userId == sharedPreferences.getString(userId)) {
        return Text(taskDetail.groupName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskDetail.fromUserName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskDetail.userId == sharedPreferences.getString(userId)) {
        return Text(taskDetail.userName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskDetail.toUser ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    }
  }

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (scaler == null) {
      scaler = new ScreenScaler()..init(context);
    }
    final titleTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _titleTextEdit,
      enabled: isEdittable,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Title",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    final descriptionTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _descriptionEdit,
      cursorWidth: 1.5,
      enabled: isEdittable,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    void onClose() {
      // Close drawer if its not large layout
      /* if (!LayoutSize.isLarge) {
        Navigator.pop(context);
      }*/
      Navigator.pop(context);
    }

    const List<String> choices = <String>[
      "Complete",
      "Cancel",
      "Pass Task",
    ];

    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              onClose();
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.chat_bubble, color: CommonColors.darkGrey),
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstants.chat,
                      arguments: ChatScreenArguments(
                          '', '', '', '', _provider.taskDetail.eventId));
                }),
            isEdittable
                ? IconButton(
                    icon: Icon(
                      Icons.done,
                      color: CommonColors.darkGrey,
                    ),
                    onPressed: () {
                      if (_titleTextEdit.text.trim().isEmpty) {
                        DialogHelper.showMessage(context, "Empty title.");
                      } else {
                        _provider
                            .updateEvent(
                                context,
                                _titleTextEdit.text,
                                priority,
                                taskDate + " " + taskTime,
                                eventStaus,
                                _descriptionEdit.text,
                                sharedPreferences.getString(userId),
                                widget.arguments,
                                sharedPreferences.getString(companyId))
                            .then((value) {
                          setState(() {
                            isEdittable = false;
                          });
                          _provider.getTaskDetail(
                              context,
                              widget.arguments,
                              sharedPreferences.getString(companyId),
                              sharedPreferences.getString(userId));
                        });
                      }
                    })
                : IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: CommonColors.darkGrey,
                    ),
                    onPressed: () {
                      setState(() {
                        isEdittable = true;
                      });
                    }),
            (eventStaus == '0' &&
                    eventUserId != sharedPreferences.getString(userId))
                ? Container()
                : PopupMenuButton<String>(
                    color: Colors.black,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      debugPrint(value);
                      if (choices.indexOf(value) == 1) {
                        eventStaus = '4';
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return TaskReasonDialogBox(
                                provider: _provider,
                                eventStatus: eventStaus,
                                eventId: widget.arguments,
                                time: Utils.getCurrentFormattedDateTime(),
                                userId: sharedPreferences.getString(userId),
                                userType: eventUserId ==
                                        sharedPreferences.getString(userId)
                                    ? '0'
                                    : '1',
                              );
                            });
                      } else if (choices.indexOf(value) == 0) {
                        _provider.acceptRejectTask(
                            context,
                            sharedPreferences.getString(userId),
                            '3',
                            widget.arguments,
                            Utils.getCurrentFormattedDateTime(),
                            eventUserId == sharedPreferences.getString(userId)
                                ? '0'
                                : '1');
                      } else if (choices.indexOf(value) == 2) {
                        Navigator.pushNamed(context,
                                RouteConstants.contact_with_radio_button,
                                arguments: _provider.taskDetail.fromContact)
                            .then((value) {
                          if (value != null) {
                            _provider
                                .passEvent(context, widget.arguments,
                                    sharedPreferences.getString(userId), value)
                                .then((value) {
                              _provider.getTaskDetail(
                                  context,
                                  widget.arguments,
                                  sharedPreferences.getString(companyId),
                                  sharedPreferences.getString(userId));
                            });
                          }
                        });
                      }
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) {
                      return choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
          ],
          title: Text(
            "Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BaseView<TaskProvider>(
          onModelReady: (provider) {
            _provider = provider;
            provider
                .getTaskDetail(
                    context,
                    widget.arguments,
                    sharedPreferences.getString(companyId),
                    sharedPreferences.getString(userId))
                .then((value) {
              setState(() {
                _titleTextEdit.text = provider.taskDetail.eventName;
                _descriptionEdit.text = provider.taskDetail.description;
                eventStaus = provider.taskDetail.status;
                eventUserId = provider.taskDetail.userId;
                priority = provider.taskDetail.priority;
                taskTime = provider.taskDetail.date.split(" ")[1];
                taskDate = provider.taskDetail.date.split(" ")[0];
              });
            });
          },
          builder: (context, provider, _) => Stack(
            children: [
              provider.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: provider.taskDetail == null
                    ? Column()
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "# " + provider.taskDetail.eventId ?? '',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Title",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            titleTextField ?? '',
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            descriptionTextField ?? '',
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "Priority",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 44.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: CustomRadioButton(
                                elevation: 0,
                                width: scaler.getWidth(25),
                                unSelectedBorderColor: Colors.grey.shade100,
                                selectedBorderColor: Colors.transparent,
                                absoluteZeroSpacing: true,
                                enableButtonWrap: true,
                                unSelectedColor: Colors.grey.shade100,
                                spacing: 96.0,
                                buttonLables: [
                                  'Low',
                                  'Medium',
                                  'High',
                                  'Critical',
                                ],
                                buttonValues: [
                                  "1",
                                  "2",
                                  "3",
                                  "4",
                                ],

                                defaultSelected: priority,
                                buttonTextStyle: ButtonTextStyle(
                                    selectedColor: Colors.white,
                                    unSelectedColor: Colors.black,
                                    textStyle: TextStyle(fontSize: 16)),
                                    radioButtonValue: (value) {
                                  if (isEdittable) {
                                    priority = value;
                                    _provider.notifyListeners();
                                  }
                                },
                                padding: 8.0,
                                enableShape: true,
                                selectedColor: getSelectedColor(),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Divider(
                              height: 1.0,
                              color: Colors.grey.shade100,
                            ),
                            Container(
                                child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: provider.taskDetail.isGroupchat ==
                                            "1"
                                        ? Container(
                                            height: 48,
                                            width: 48,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.green,
                                                    style: BorderStyle.solid)),
                                            child: Center(
                                              child: Text(
                                                groupShortName(provider
                                                        .taskDetail.toUser ??
                                                    ''),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 24,
                                            backgroundImage: NetworkImage(
                                                provider.taskDetail.userId ==
                                                        sharedPreferences
                                                            .getString(userId)
                                                    ? provider.taskDetail
                                                        .receiverPpThumbnail
                                                    : provider.taskDetail
                                                        .senderPpThumbnail),
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
                                        Row(
                                          children: [
                                            _setToUserName(provider.taskDetail),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            provider.taskDetail.userId ==
                                                    sharedPreferences
                                                        .getString(userId)
                                                ? ImageIcon(
                                                    AssetImage(
                                                        "assets/images/ic_left_greenarrow.png"),
                                                    size: 24.0,
                                                    color: Colors.green,
                                                  )
                                                : ImageIcon(
                                                    AssetImage(
                                                        "assets/images/ic_right_arrow.png"),
                                                    size: 24.0,
                                                    color: CommonColors.red,
                                                  ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            _setFromUserName(
                                                provider.taskDetail),
                                          ],
                                        ),
                                        SizedBox(height: 8.0,),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer,
                                                    color: CommonColors.darkGrey,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 4.0,),
                                                  Text(
                                                    taskTime,
                                                    style: TextStyle(
                                                        color: CommonColors
                                                            .darkGrey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    color:
                                                        CommonColors.darkGrey,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 4.0,),
                                                  Text(
                                                    taskDate,
                                                    style: TextStyle(
                                                        color: CommonColors
                                                            .darkGrey),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Divider(
                              height: 1.0,
                              color: Colors.grey.shade100,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    provider.taskDetail.eventdetail.length,
                                itemBuilder: (context, position) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        provider
                                                            .taskDetail
                                                            .eventdetail[
                                                                position]
                                                            .date
                                                            .split(" ")[0],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      provider
                                                          .taskDetail
                                                          .eventdetail[position]
                                                          .date
                                                          .split(" ")[1],
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: 180,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          new Radius.circular(
                                                              24.0)),
                                                  color:
                                                      CommonColors.lightGreen),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                          provider
                                                              .taskDetail
                                                              .eventdetail[
                                                                  position]
                                                              .status
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Divider(
                                          height: 1.0,
                                          color: Colors.grey.shade100,
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 40.0,
                            ),
                            (eventStaus == '0' &&
                                    eventUserId !=
                                        sharedPreferences.getString(userId))
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: BounceButton(
                                            isLoading: false,
                                            onPressed: () {
                                              provider.acceptRejectTask(
                                                  context,
                                                  sharedPreferences
                                                      .getString(userId),
                                                  '1',
                                                  widget.arguments,
                                                  Utils
                                                      .getCurrentFormattedDateTime(),
                                                  eventUserId ==
                                                          sharedPreferences
                                                              .getString(userId)
                                                      ? '0'
                                                      : '1');
                                            },
                                            text: "Accept",
                                            color: CommonColors.green,
                                            textColor: Colors.white),
                                      ),
                                      Container(
                                        width: 200,
                                        child: BounceButton(
                                            isLoading: false,
                                            onPressed: () {
                                              provider.acceptRejectTask(
                                                  context,
                                                  sharedPreferences
                                                      .getString(userId),
                                                  '2',
                                                  widget.arguments,
                                                  Utils
                                                      .getCurrentFormattedDateTime(),
                                                  eventUserId ==
                                                          sharedPreferences
                                                              .getString(userId)
                                                      ? '0'
                                                      : '1');
                                            },
                                            text: "Reject",
                                            color: CommonColors.red,
                                            textColor: Colors.white),
                                      ),
                                      Container(
                                        width: 200,
                                        child: BounceButton(
                                            isLoading: false,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                      context,
                                                      RouteConstants
                                                          .contact_with_radio_button,
                                                      arguments: provider
                                                          .taskDetail
                                                          .fromContact)
                                                  .then((value) {
                                                if (value != null) {
                                                  provider
                                                      .passEvent(
                                                          context,
                                                          widget.arguments,
                                                          sharedPreferences
                                                              .getString(
                                                                  userId),
                                                          value)
                                                      .then((value) {
                                                    provider.getTaskDetail(
                                                        context,
                                                        widget.arguments,
                                                        sharedPreferences
                                                            .getString(
                                                                companyId),
                                                        sharedPreferences
                                                            .getString(userId));
                                                  });
                                                }
                                              });
                                            },
                                            text: "Pass",
                                            color: CommonColors.blue,
                                            textColor: Colors.white),
                                      )
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSelectedColor() {
    if (priority == "1") {
      return CommonColors.green;
    } else if (priority == "2") {
      return CommonColors.blue;
    } else if (priority == "3") {
      return CommonColors.primaryColor;
    } else if (priority == "4") {
      return CommonColors.red;
    }
  }
}
