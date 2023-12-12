import 'package:desk/components/daily_report_dialog.dart';
import 'package:desk/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckOutDialogBox extends StatefulWidget {
  final MainProvider provider;
  final BuildContext c;

  const CheckOutDialogBox({ Key key,  this.provider, this.c}) : super(key: key);

  @override
  _CheckOutDialogBoxState createState() => _CheckOutDialogBoxState();
}

class _CheckOutDialogBoxState extends State<CheckOutDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(widget.c),
    );
  }

  contentBox(BuildContext context) {
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
                'Check In/Out',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  widget.provider.attendence(context, '2');
                },
                child: Text(
                  'Check Out \n(I will be back today)',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DailyReportDialogBox(
                            provider: widget.provider);
                      });
                },
                child: Text(
                  'Check Out \n(Done for the day)',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              SizedBox(
                height: 6,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'CANCEL',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ), // bottom partpart
      ],
    );
  }
}