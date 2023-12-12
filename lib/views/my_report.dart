import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/daily_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyReport extends StatefulWidget {
  @override
  _DailyReportState createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  final _dailyReportTextEdit = TextEditingController();
  String _totalEmail = "";
  List<String> mEmailList = [];


  @override
  void initState() {
    super.initState();
    _dailyReportTextEdit.addListener(_printLatestValue);
  }

  void dispose() {
    _dailyReportTextEdit.dispose();
    super.dispose();
  }

  _printLatestValue() {
    if (_dailyReportTextEdit.text.toString().contains(" ") ||
        _dailyReportTextEdit.text.toString().contains(",")) {
      String email = _dailyReportTextEdit.text.toString().trim();
      if (email.contains(" ")) {
        List<String> emails = email.split(" ");
        if (emails.length >= 1) {
          for (int i = 0; i < emails.length; i++) {
            debugPrint(emails[i]);
            if (emails[i].isNotEmpty && Validation.isEmail(emails[i])) {
              mEmailList.add(emails[i]);
              debugPrint(emails[i]);
              _dailyReportTextEdit.text = '';
              setState(() {
                _totalEmail = mEmailList.length.toString();
              });
            }
          }
        }
      }else  if (email.contains(",")) {
        List<String> emails = email.split(",");
        if (emails.length >= 1) {
          for (int i = 0; i < emails.length; i++) {
            debugPrint(emails[i]);
            if (emails[i].isNotEmpty && Validation.isEmail(emails[i])) {
              mEmailList.add(emails[i]);
              debugPrint(emails[i]);
              _dailyReportTextEdit.text = '';
              setState(() {
                _totalEmail = mEmailList.length.toString();
              });
            }
          }
        }
      }

      else if ((email).isNotEmpty &&
          Validation.isEmail(_dailyReportTextEdit.text.trim())) {
        mEmailList.add(_dailyReportTextEdit.text.toString());

        _dailyReportTextEdit.text = '';
        setState(() {
          _totalEmail = mEmailList.length.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inviteEmailTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _dailyReportTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      minLines: 10,
      maxLines: 10,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Enter Daily Report...",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.all(12.0),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text(
          "Daily Report",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<DailyProvider>(
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

                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: mEmailList.length,
                          itemBuilder: (context,position){
                            return Container(
                              child: Text(
                                mEmailList[position],
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    inviteEmailTextField,
                    SizedBox(
                      height: 12.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:  Text(
                        _totalEmail,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      child: Container(
                        width: 200,
                        child: BounceButton(
                            isLoading: provider.state==ViewState.Busy?true:false,
                            onPressed: () {
                              if(_dailyReportTextEdit.text.isNotEmpty){
                                provider.dailyReport(context,_dailyReportTextEdit.text).then((value)
                                {
                                  if(value){
                                    _dailyReportTextEdit.text='';
                                  }
                                });
                              }else{
                                DialogHelper.showMessage(context, 'Please enter your message');
                              }
                            },
                            text: "Send",
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
