import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/change_password_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();

  final _newPasswordTextEdit = TextEditingController();
  final _confirmPasswordTextEdit = TextEditingController();


  @override
  void initState() {
    super.initState();

  }

  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    final newPasswordTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _newPasswordTextEdit,
      cursorWidth: 1.5,
      obscureText: true,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "New Password",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );


    final confirmPasswordTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _confirmPasswordTextEdit,
      cursorWidth: 1.5,
      obscureText: true,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Confirm New Password",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );


    return Scaffold(
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
           Navigator.pop(context);
          },
        ),
        title: Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<ChangePasswordProvider>(
        onModelReady: (provider) {},
        builder: (context, provider, _) => Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child:  Image(
                        width: 96.0,
                        height: 96.0,
                        image:AssetImage("assets/images/ic_change_password.png"),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      "New Password",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    newPasswordTextField,
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Confirm New Password",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    confirmPasswordTextField,

                    SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      child: Container(
                        width: 200,
                        child: BounceButton(
                            isLoading: provider.state==ViewState.Busy?true:false,
                            onPressed: () {
                             if(_newPasswordTextEdit.text.length==0){
                              DialogHelper.showMessage(context, 'Enter new password');
                             }else  if(_confirmPasswordTextEdit.text.length==0){
                               DialogHelper.showMessage(context, 'Enter confirm password');
                             }else if(_newPasswordTextEdit.text.toString()!=_confirmPasswordTextEdit.text.toString()){
                               DialogHelper.showMessage(context, 'Password does\'t match');
                             }else{
                               provider.changePassword(context, _sharedPreferences.getString(userId), _newPasswordTextEdit.text.toString());
                             }
                            },
                            text: "Done",
                            color: CommonColors.red,
                            textColor: Colors.white),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
