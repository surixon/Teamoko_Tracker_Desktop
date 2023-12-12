import 'dart:io';

import 'package:desk/base/base_view.dart';
import 'package:desk/components/image_view.dart';
import 'package:desk/provider/profile_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:desk/utils/validations.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _companyTextEdit = TextEditingController();
  final _employeeIdTextEdit = TextEditingController();
  final _fullNameTextEdit = TextEditingController();
  final _designationTextEdit = TextEditingController();
  final _emailTextEdit = TextEditingController();
  final _mobileTextEdit = TextEditingController();
  final _dobTextEdit = TextEditingController();
  ProfileProvider _provider;
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  int genderValue = 1;

  @override
  Widget build(BuildContext context) {
    final titleTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _companyTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintText: "Title",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    final employeeIdTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _employeeIdTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintText: "Description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    final fullNameTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _fullNameTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintText: "Description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    final designationTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _designationTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintText: "Description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    final emailTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _emailTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintText: "Description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    final mobileTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _mobileTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintText: "Description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    final dobTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _dobTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintText: "Description",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

    return Scaffold(
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              color: Colors.black,
              icon: Icon(Icons.done),
              onPressed: () {
                if (_provider.profileResponse == null &&
                    _provider.profileImageFile == null) {
                  DialogHelper.showMessage(context, 'Please add profile photo');
                } else if (_fullNameTextEdit.text.isEmpty) {
                  DialogHelper.showMessage(context, 'Please enter full name');
                } else if (_emailTextEdit.text.isEmpty) {
                  DialogHelper.showMessage(context, 'Please enter E-mail Id');
                } else if (!Validations.emailValidation(
                    _emailTextEdit.text.trim())) {
                  DialogHelper.showMessage(
                      context, StringConstants.invalid_email);
                } else if (_designationTextEdit.text.isEmpty) {
                  DialogHelper.showMessage(context, 'Please enter designation');
                } else {
                  _provider.updateProfile(
                      context,
                      _provider.profileResponse.response.data.countryCode,
                      _provider.profileResponse.response.data.country,
                      _provider.profileResponse.response.data.companyId,
                      _fullNameTextEdit.text.trim(),
                      _designationTextEdit.text.trim(),
                      _emailTextEdit.text.trim(),
                      _dobTextEdit.text.trim(),
                      genderValue.toString(),
                      _provider.profileResponse.response.data.employeeId,
                      _provider.profileResponse.response.data.contact,
                      _provider.profileImageFile);
                }
              })
        ],
      ),
      body: BaseView<ProfileProvider>(
        onModelReady: (provider) {
          _provider = provider;
          provider.getProfile(context).then((value) {
            _companyTextEdit.text =
                provider.profileResponse.response.data.companyName;
            _employeeIdTextEdit.text =
                provider.profileResponse.response.data.employeeId;
            _fullNameTextEdit.text =
                provider.profileResponse.response.data.fullname;
            _designationTextEdit.text =
                provider.profileResponse.response.data.designation;
            _emailTextEdit.text = provider.profileResponse.response.data.email;
            _mobileTextEdit.text =
                provider.profileResponse.response.data.contact;
            _dobTextEdit.text = provider.profileResponse.response.data.dob;

            genderValue =
                int.parse(provider.profileResponse.response.data.gender);
          });
        },
        builder: (context, provider, _) => Padding(
          padding: EdgeInsets.all(16.0),
          child: provider.profileResponse == null
              ? Column()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_sharedPreferences.getString(userType) ==
                                    '4') {
                                  selectImage('1');
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: _provider.coverImageFile != null
                                    ? ImageView(
                                        file: _provider.coverImageFile,
                                        fit: BoxFit.cover,
                                        height: 250,
                                        width: double.infinity,
                                        color: CommonColors.primaryColor
                                            .withOpacity(0.7),
                                      )
                                    : Image.network(
                                        provider.profileResponse == null
                                            ? ''
                                            : provider.profileResponse.response
                                                .data.coverPic,
                                        height: 250,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectImage('2');
                              },
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 250,
                                    child: _provider.profileImageFile != null
                                        ? Center(
                                            child: ImageView(
                                            file: _provider.profileImageFile,
                                            radius: 36,
                                            fit: BoxFit.fitHeight,
                                            circleCrop: true,
                                          ))
                                        : Center(
                                            child: CircleAvatar(
                                            radius: 36,
                                            backgroundImage: NetworkImage(
                                                provider.profileResponse == null
                                                    ? ''
                                                    : provider
                                                        .profileResponse
                                                        .response
                                                        .data
                                                        .profilePic),
                                          )),
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/ic_company.png"),
                              size: 32.0,
                              color: CommonColors.primaryColor,
                            ),
                            Expanded(
                              child: titleTextField,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/ic_employee_id.png"),
                              size: 32.0,
                              color: CommonColors.primaryColor,
                            ),
                            Expanded(
                              child: employeeIdTextField,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/ic_icon_user.png"),
                              size: 32.0,
                              color: CommonColors.primaryColor,
                            ),
                            Expanded(
                              child: fullNameTextField,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/ic_designation.png"),
                              size: 32.0,
                              color: CommonColors.primaryColor,
                            ),
                            Expanded(
                              child: designationTextField,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/ic_email.png"),
                              size: 32.0,
                              color: CommonColors.primaryColor,
                            ),
                            Expanded(
                              child: emailTextField,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/ic_phone.png"),
                              size: 32.0,
                              color: CommonColors.primaryColor,
                            ),
                            Expanded(
                              child: mobileTextField,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/ic_date.png"),
                              size: 32.0,
                              color: CommonColors.primaryColor,
                            ),
                            Expanded(
                              child: dobTextField,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Gender :',
                            style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Radio(
                            value: 1,
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                            groupValue: genderValue,
                            onChanged: (val) {
                              setState(() {
                                genderValue = 1;
                              });
                            },
                          ),
                          Text(
                            'Male',
                            style: new TextStyle(
                                color: Colors.black, fontSize: 17.0),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Radio(
                            value: 2,
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                            groupValue: genderValue,
                            onChanged: (val) {
                              setState(() {
                                genderValue = 2;
                              });
                            },
                          ),
                          Text(
                            'Female',
                            style: new TextStyle(
                                color: Colors.black, fontSize: 17.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> selectImage(String type) async {
    FilePickerCross file = await FilePickerCross.importFromStorage(
        type: FileTypeCross.custom,
        // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            'png,jpeg,jpg' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
        );
    _provider.setImage(context, file.path, type);
  }
}
