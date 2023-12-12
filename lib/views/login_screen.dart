import 'dart:io';
import 'dart:ui';

import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/login_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/keyboard_helper.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:desk/utils/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  var _agreedToTOS = false;

  _launchURL() async {
    const url = 'https://www.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Future<void> initState() {
    super.initState();
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      /*DesktopWindow.setWindowSize(Size(420, 680));
      DesktopWindow.setMinWindowSize(Size(420, 680));
      DesktopWindow.setMaxWindowSize(Size(420, 680));*/
    }
  }




  @override
  void dispose() {
    _passwordText.dispose();
    _emailText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _emailText,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(color: Color(0xff1B1D21)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          fillColor: Colors.white),
    );
    final passwordTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _passwordText,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Color(0xff1B1D21)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          fillColor: Colors.white),
    );

    return Scaffold(
      body: BaseView<LoginProvider>(
        onModelReady: (provider) {},
        builder: (context, provider, _) => Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_login.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/images/ic_logo_login.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                    height: 16.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("assets/images/ic_password.png"),
                          size: 32.0,
                          color: CommonColors.primaryColor,
                        ),
                        Expanded(
                          child: passwordTextField,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          activeColor: CommonColors.primaryColor,
                          checkColor: Colors.white,
                          value: _agreedToTOS,
                          onChanged: (bool isChecked) {
                            setState(() {
                              _agreedToTOS = isChecked;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                "I confirm that i have read and agree to the ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            TextSpan(
                                text: "Terms & Conditions ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: CommonColors.primaryColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchURL();
                                  }),
                            TextSpan(
                                text: "and ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: CommonColors.primaryColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchURL();
                                  }),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RouteConstants.forgot_password);
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    width: 200.0,
                    child: BounceButton(
                        isLoading:
                        provider.state == ViewState.Busy ? true : false,
                        onPressed: () {
                          KeyboardHelper.hideKeyboard(context);
                          if (_emailText.text.trim().isEmpty) {
                            DialogHelper.showMessage(
                                context, StringConstants.empty_email);
                          } else if (!Validations.emailValidation(
                              _emailText.text.trim())) {
                            DialogHelper.showMessage(
                                context, StringConstants.invalid_email);
                          } else if (_passwordText.text.trim().isEmpty) {
                            DialogHelper.showMessage(
                                context, StringConstants.enter_your_password);
                          } else if (!_agreedToTOS) {
                            DialogHelper.showMessage(context,
                                StringConstants.accept_term_of_service);
                          } else {
                            provider.login(context, _emailText.text.trim(),
                                _passwordText.text.trim());
                          }
                        },
                        text: "Sign In",
                        color: CommonColors.primaryColor,
                        textColor: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
