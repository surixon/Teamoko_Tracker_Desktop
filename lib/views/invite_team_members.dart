import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/invite_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InviteTeamMembers extends StatefulWidget {
  @override
  _InviteTeamMembersState createState() => _InviteTeamMembersState();
}

class _InviteTeamMembersState extends State<InviteTeamMembers> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  final _inviteTextEdit = TextEditingController();
  InviteProvider _provider;

  @override
  void initState() {
    super.initState();
    _inviteTextEdit.addListener(_printLatestValue);
  }

  void dispose() {
    _inviteTextEdit.dispose();
    super.dispose();
  }

  _printLatestValue() {
    if (_inviteTextEdit.text.toString().contains(" ") ||
        _inviteTextEdit.text.toString().contains(",")) {
      String email = _inviteTextEdit.text.toString().trim();
      if (email.contains(" ")) {
        List<String> emails = email.split(" ");
        if (emails.length >= 1) {
          for (int i = 0; i < emails.length; i++) {
            debugPrint(emails[i]);
            if (emails[i].isNotEmpty && Validation.isEmail(emails[i])) {
              _provider.emailList.add(emails[i]);
              debugPrint(emails[i]);
              _inviteTextEdit.text = '';
              _provider.updateTotalEmailCount();
            }
          }
        }
      } else if (email.contains(",")) {
        List<String> emails = email.split(",");
        if (emails.length >= 1) {
          for (int i = 0; i < emails.length; i++) {
            debugPrint(emails[i]);
            if (emails[i].isNotEmpty && Validation.isEmail(emails[i])) {
              _provider.emailList.add(emails[i]);
              debugPrint(emails[i]);
              _inviteTextEdit.text = '';
              _provider.updateTotalEmailCount();
            }
          }
        }
      } else if ((email).isNotEmpty &&
          Validation.isEmail(_inviteTextEdit.text.trim())) {
        _provider.emailList.add(_inviteTextEdit.text.toString());

        _inviteTextEdit.text = '';
        _provider.updateTotalEmailCount();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inviteEmailTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _inviteTextEdit,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Enter email(s) separated by space or comma...",
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
        title: Text(
          "Invite team members",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<InviteProvider>(
        onModelReady: (provider) {
          _provider = provider;
        },
        builder: (context, provider, _) => Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    inviteEmailTextField,

                    SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      child: Container(
                        width: 200,
                        child: BounceButton(
                            isLoading:
                                provider.state == ViewState.Busy ? true : false,
                            onPressed: () {
                              if (_provider.emailList.length > 0) {
                                String emails = "";
                                for (int i = 0;
                                    i < _provider.emailList.length;
                                    i++) {
                                  emails =
                                      emails + _provider.emailList[i] + ",";
                                }
                                emails = emails.substring(0, emails.length - 1);
                                provider.inviteMember(
                                    context,
                                    _sharedPreferences.getString(userEmail),
                                    emails,
                                    _sharedPreferences.getString(companyId));
                              } else {
                                DialogHelper.showMessage(context,
                                    'Enter atleast one email address.');
                              }
                            },
                            text: "Invite",
                            color: CommonColors.red,
                            textColor: Colors.white),
                      ),
                      alignment: Alignment.centerRight,
                    ),

                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: ListView.separated(

                          shrinkWrap: true,
                          itemCount: _provider.emailList.length,
                          itemBuilder: (context, position) {
                            return Wrap(children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _provider.emailList[position],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          provider.removeItem(position);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: CommonColors.darkGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],);
                          },   separatorBuilder: (context, index) => SizedBox(
                       height: 4.0,
                      ),),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _provider.totalEmail,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
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
