import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/support_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  final _supportMessageEditText = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supportMessageTextField = TextField(
      style: TextStyle(color: Colors.black),
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      minLines: 10,
      controller: _supportMessageEditText,
      maxLines: 10,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Enter your message",
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
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Support",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<SupportProvider>(
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
                    SizedBox(
                      height: 12.0,
                    ),
                    supportMessageTextField,
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 200,
                            child: BounceButton(
                                isLoading: provider.state == ViewState.Busy
                                    ? true
                                    : false,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteConstants.ticket_status);
                                },
                                text: "View Status",
                                color: CommonColors.red,
                                textColor: Colors.white),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            width: 200,
                            child: BounceButton(
                                isLoading: provider.state == ViewState.Busy
                                    ? true
                                    : false,
                                onPressed: () {
                                  if (_supportMessageEditText.text.isEmpty) {
                                    DialogHelper.showMessage(
                                        context, 'Please enter your message');
                                  } else {
                                    provider
                                        .genrateTicket(
                                            context,
                                            _sharedPreferences
                                                .getString(userId),
                                            _supportMessageEditText.text
                                                .toString())
                                        .then((value) => {
                                              if (value)
                                                {
                                                  _supportMessageEditText.text =
                                                      ''
                                                }
                                            });
                                  }
                                },
                                text: "Submit",
                                color: CommonColors.red,
                                textColor: Colors.white),
                          )
                        ],
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
