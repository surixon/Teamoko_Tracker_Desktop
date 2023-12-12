// @dart=2.9
import 'package:desk/provider/tasks_provider.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskReasonDialogBox extends StatefulWidget {
  final TaskProvider provider;
  final String eventStatus;
  final String eventId;
  final String time;
  final String userId;
  final String userType;


  const TaskReasonDialogBox({Key key, this.provider,this.eventStatus,this.eventId,this.time,this.userId,this.userType}) : super(key: key);

  @override
  _TaskReasonDialogBoxState createState() => _TaskReasonDialogBoxState();
}

class _TaskReasonDialogBoxState extends State<TaskReasonDialogBox> {
  final _reasonText = TextEditingController();

  String _title(){
    if(widget.eventStatus=='4'){
      return 'Canceled';
    }
    return '';
  }

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
                _title(),
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
                controller: _reasonText,
                cursorWidth: 1.5,
                maxLines: 5,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "Enter reason...",
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
                child: Text('Done'),
                // textColor: Colors.white,
                // color: Colors.red,
                onPressed: () {
                 if(_reasonText.text.toString().isEmpty){
                   DialogHelper.showMessage(context, 'Please enter your reason');
                 }else{
                   Navigator.pop(context);
                   if(widget.eventStatus=='4'){
                     widget.provider.acceptRejectTask(context, widget.userId,widget.eventStatus,widget.eventId,widget.time,widget.userType);
                   }

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
