import 'dart:io';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:desk/base/base_view.dart';
import 'package:desk/components/image_view.dart';
import 'package:desk/model/arguments_contact_list_to_add_task.dart';
import 'package:desk/provider/add_task_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  var arguments;

  AddTaskPage({this.arguments});

  @override
  AddTaskPageState createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  File _imageFile;
  File _videoFile;
  ScreenScaler scaler;
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  AddTaskProvider _addTaskProvider;
  var _toName = 'Select name';
  var _toContact = '';
  var groupId = '';
  var to = '';
  var from = '';
  var _latitude = '';
  var _longitude = '';
  var _radius = '';
  var _comingIn = '';
  var _address = '';
  var _userName = '';
  var _groupName = '';
  var _deviceToken = '';
  var _deviceType = '';
  var _dueDate = '';

  final DateFormat formatter = DateFormat('dd-MMM-yy');

  final _titleTextEdit = TextEditingController();
  final _descriptionEdit = TextEditingController();

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = TimeOfDay.fromDateTime(DateTime.now());

  Future<void> _showDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _fromDate) {
      setState(() {
        _fromDate = picked;
      });
    }
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

    _dueDate = formatter.format(_fromDate) + ' ' + _fromTime.format(context);

    final titleTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _titleTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Enter title",
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
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Enter description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    String getCurrentTime() {
      return formatter.format(DateTime.now()) +
          ' ' +
          TimeOfDay.fromDateTime(DateTime.now()).format(context);
    }

    void onClose() {
      Navigator.pop(context);
    }

    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1.0,
          centerTitle: true,
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
          title: Text(
            "Add Task",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.black,
              ),
              onPressed: () {
                DialogHelper.showMessage(context, 'done');
                _addTaskProvider.addTask(
                    context,
                    groupId,
                    to,
                    from,
                    _titleTextEdit.text,
                    _addTaskProvider.priority,
                    _dueDate,
                    ' ',
                    'To',
                    _deviceToken,
                    _deviceType,
                    getCurrentTime(),
                    _descriptionEdit.text,
                    _sharedPreferences.getString(userType),
                    '',
                    _toContact,
                    _latitude,
                    _longitude,
                    _radius,
                    _comingIn,
                    _address,
                    _userName,
                    _groupName,
                    _imageFile,
                    _videoFile);
              },
            )
          ],
        ),
        body: BaseView<AddTaskProvider>(
          onModelReady: (provider) {
            _addTaskProvider = provider;
          },
          builder: (context, provider, _) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  titleTextField,
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  descriptionTextField,
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteConstants.contact_list)
                          .then((data) {
                        if (data != null) {
                          var object = data as DataContactListToAddTask;
                          setState(() {
                            _toName = object.names;
                            _toContact = object.contacts;
                          });
                        }
                      });
                    },
                    child: Container(
                      height: 44.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.grey.shade100),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            _toName,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Priority",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 44.0,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: CustomRadioButton(
                      elevation: 0,
                      width: scaler.getWidth(25),
                      unSelectedBorderColor: Colors.grey.shade100,
                      selectedBorderColor: Colors.transparent,
                      absoluteZeroSpacing: true,
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
                      defaultSelected: '4',
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: TextStyle(fontSize: 16)),
                      radioButtonValue: (value) {
                        print(value);
                        _addTaskProvider.priority = value;
                        _addTaskProvider.notifyListeners();
                      },
                      padding: 8.0,
                      enableShape: true,
                      selectedColor: getSelectedColor(),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Due Date",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      width: double.infinity,
                      height: 44.0,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 6.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDatePicker(context);
                            },
                            child: Text(
                              _dueDate,
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Upload Files",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            // show a dialog to open a file
                            selectImage();
                          },
                          child: _imageFile == null
                              ? Column(
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                          "assets/images/ic_icon_image_pink.png"),
                                      size: 40.0,
                                      color: CommonColors.primaryColor,
                                    ),
                                    Text(
                                      "Select Image",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : ImageView(
                                  file: _imageFile,
                                  fit: BoxFit.cover,
                                  width: scaler.getWidth(20),
                                  height: scaler.getWidth(20),
                                  color: CommonColors.primaryColor
                                      .withOpacity(0.7),
                                )),
                      GestureDetector(
                        onTap: () {
                          selectVideo();
                        },
                        child: _videoFile == null
                            ? Column(
                                children: [
                                  ImageIcon(
                                    AssetImage(
                                        "assets/images/ic_icon_video_pink.png"),
                                    size: 40.0,
                                    color: CommonColors.primaryColor,
                                  ),
                                  Text(
                                    "Select Video",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            : ImageView(
                                file: _videoFile,
                                fit: BoxFit.cover,
                                width: scaler.getWidth(20),
                                height: scaler.getWidth(20),
                                color:
                                    CommonColors.primaryColor.withOpacity(0.7),
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getSelectedColor() {
    if (_addTaskProvider.priority == "1") {
      return CommonColors.green;
    } else if (_addTaskProvider.priority == "2") {
      return CommonColors.blue;
    } else if (_addTaskProvider.priority == "3") {
      return CommonColors.primaryColor;
    } else if (_addTaskProvider.priority == "4") {
      return CommonColors.red;
    }
  }

  Future<void> selectImage() async {
    FilePickerCross file = await FilePickerCross.importFromStorage(
        type: FileTypeCross.custom,
        // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            'png,jpeg,jpg' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
        );
    var path = file.path;
    _imageFile = File('$path');
    print(_imageFile.path);
    _addTaskProvider.notifyListeners();
  }

  Future<void> selectVideo() async {
    FilePickerCross file = await FilePickerCross.importFromStorage(
        type: FileTypeCross.custom,
        // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            'wmv,mp4,avi,mov,flv,f4v,f4p,f4a,f4b,flv,webcam' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
        );
    var path = file.path;
    _videoFile = File('$path');
    print(_videoFile.path);
    _addTaskProvider.notifyListeners();
  }
}
