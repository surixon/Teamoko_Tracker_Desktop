// @dart=2.9
import 'package:desk/provider/main_provider.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyReportDialogBox extends StatefulWidget {
  final MainProvider provider;

  const DailyReportDialogBox({Key key, this.provider}) : super(key: key);

  @override
  _DailyReportDialogBoxState createState() => _DailyReportDialogBoxState();
}

class _DailyReportDialogBoxState extends State<DailyReportDialogBox> {
  final _dailyReportText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 300.0,
          padding:
              EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Daily Report',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _dailyReportText,
                cursorWidth: 1.5,
                maxLines: 5,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "Enter Daily Report...",
                    hintStyle: TextStyle(color: Color(0xff1B1D21)),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(8),
                    fillColor: Colors.white),
              ),
              SizedBox(height: 12.0,),
              TextButton(
                child: Text('Check Out'),
                // textColor: Colors.white,
                // color: Colors.red,
                onPressed: () {
                 if(_dailyReportText.text.toString().isEmpty){
                   DialogHelper.showMessage(context, 'Please enter your report');
                 }else{
                   Navigator.pop(context);
                   widget.provider.dailyReport(context, _dailyReportText.text.toString());
                 }
                },
              ),
            ],
          ),
        ), // bottom partpart
      ],
    );
  }
}
