import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/login_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  final _emailTextEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _emailTextEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inviteEmailTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _emailTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Email",
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
          "Forgot Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<LoginProvider>(
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
                        image:AssetImage("assets/images/ic_forgot_password.png"),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Forgot Your Password ?",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "We just need your registerd email to send you password reset.",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    inviteEmailTextField,
                    SizedBox(
                      height: 18.0,
                    ),
                    Align(
                      child: Container(
                        width: 200,
                        child: BounceButton(
                            isLoading:
                                provider.state == ViewState.Busy ? true : false,
                            onPressed: () {
                              if (_emailTextEdit.text.isEmpty) {
                                DialogHelper.showMessage(
                                    context, 'Please enter E-mail Id');
                              } else  if (!Validation.isEmail(_emailTextEdit.text.toString())) {
                                DialogHelper.showMessage(
                                    context, 'Invalid Email');
                              } else {
                                provider.forgotPassword(context,
                                    _sharedPreferences.getString(userEmail));
                              }
                            },
                            text: "Next",
                            color: CommonColors.red,
                            textColor: Colors.white),
                      ),
                      alignment: Alignment.center,
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
