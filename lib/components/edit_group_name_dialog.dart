// @dart=2.9
import 'package:desk/model/group_list_response.dart';
import 'package:desk/provider/group_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditGroupNameDialogBox extends StatefulWidget {
  final GroupProvider provider;
  final GroupDatum groupData;
  final int index;

  const EditGroupNameDialogBox({Key key, this.provider,this.groupData,this.index}) : super(key: key);

  @override
  _EditGroupNameDialogBoxState createState() => _EditGroupNameDialogBoxState();
}

class _EditGroupNameDialogBoxState extends State<EditGroupNameDialogBox> {
  final _groupTitle = TextEditingController();

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
    _groupTitle.text=widget.groupData.groupName;

    final titleTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _groupTitle,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: "Title",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
    );

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
                'Group name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8,),
              Text(
                'Enter group name',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),

              titleTextField,
              SizedBox(
                height: 12,
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  Container(
                    width: 2.0,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      if(_groupTitle.text.toString().isEmpty){
                        DialogHelper.showMessage(context, 'Enter group name');
                      }else{
                        widget.provider.updateGroup(context, widget.groupData.groupId, _groupTitle.text.toString(),widget.index);
                      }
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 14, color: CommonColors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
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