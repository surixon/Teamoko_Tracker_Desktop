import 'package:desk/base/base_view.dart';
import 'package:desk/model/contact_user_response.dart';
import 'package:desk/provider/group_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupSubject extends StatefulWidget {
  List<ContactsDatum> argumrntList;

  GroupSubject({this.argumrntList});

  @override
  _GroupSubjectState createState() => _GroupSubjectState();
}

class _GroupSubjectState extends State<GroupSubject> {
  GroupProvider _provider;
  final _groupTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final titleTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _groupTitle,
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: "Type group subject here...",
          hintStyle: TextStyle(color: Color(0xff1B1D21)),
          contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: CommonColors.primaryColor))),
    );

    return Scaffold(
      appBar: AppBar(
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
          "Add Subject",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: BaseView<GroupProvider>(
          onModelReady: (provider) {
            _provider = provider;
          },
          builder: (context, provider, _) => Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleTextField,
                      SizedBox(height: 8.0,),
                      Text('Provide a group subject',style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 8,
                  children: List.generate(widget.argumrntList.length, (index) {
                    return Container(
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                  widget.argumrntList[index].ppThumbnail),
                            ),
                            Text(
                              widget.argumrntList[index].fullname,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String toContacts;
          if (_groupTitle.text.toString().isEmpty) {
            DialogHelper.showMessage(context, 'Enter group title');
          } else {
            for (var i = 0; i < widget.argumrntList.length; i++) {
              toContacts = widget.argumrntList[i].contact + ",";
            }
            toContacts = toContacts.substring(0, toContacts.length - 1);
            _provider.createGroup(
                context, _groupTitle.text.toString(), toContacts);
          }
        },
        elevation: 0.0,
        child: new Icon(
          Icons.done,
          color: Colors.white,
        ),
        backgroundColor: CommonColors.primaryColor,
      ),
    );
  }
}
