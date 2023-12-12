import 'package:desk/base/base_view.dart';
import 'package:desk/model/contact_user_response.dart';
import 'package:desk/provider/contact_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewGroupScreen extends StatefulWidget {
  @override
  _NewGroupScreenState createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  int page = 1;
  bool selectAll = false;
  ContactProvider _provider;

  Future _loadMore(BuildContext context, ContactProvider provider) async {
    provider.myContactList(context, '0', page.toString(), '');
  }

  @override
  Widget build(BuildContext context) {
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
          "New Group",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: BaseView<ContactProvider>(
            onModelReady: (provider) {
              _provider = provider;
              provider.myContactList(context, '0', page.toString(), '');
            },
            builder: (context, provider, _) => Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            Checkbox(
                              activeColor: Colors.red,
                              checkColor: Colors.white,
                              value: selectAll,
                              onChanged: (bool isChecked) {
                                setState(() {
                                  selectAll = isChecked;
                                  for (var i = 0;
                                      i < provider.contactList.length;
                                      i++) {
                                    provider.contactList[i].isChecked =
                                        isChecked;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "Select All",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13.0),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        // ignore: missing_return
                        onNotification: (ScrollNotification scrollInfo) {
                          if (page < provider.lastPage &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            setState(() {
                              page = page + 1;
                            });
                            _loadMore(context, provider);
                          }
                        },
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: provider.contactList.length,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 8.0, 10.0, 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Checkbox(
                                              activeColor: provider
                                                  .contactList[position]
                                                  .isChecked
                                                  ? CommonColors.primaryColor
                                                  : Colors.purple,
                                              checkColor: Colors.white,
                                              value: provider
                                                  .contactList[position]
                                                  .isChecked,
                                              onChanged: (bool isChecked) {
                                                setState(() {
                                                  provider.contactList[position]
                                                      .isChecked = isChecked;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Center(
                                              child: CircleAvatar(
                                                radius: 24,
                                                backgroundImage: NetworkImage(
                                                    provider.contactList[position]
                                                        .ppThumbnail),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    provider.contactList[position]
                                                        .fullname,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18.0),
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    provider.contactList[position]
                                                        .designation,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 14.0),
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    provider.contactList[position]
                                                        .contact,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 14.0),
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            );
                          },   separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade300,
                      ),
                        ),
                      ),
                    )
                  ],
                )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<ContactsDatum> selectedContactList = [];

          for (var i = 0; i < _provider.contactList.length; i++) {
            if (_provider.contactList[i].isChecked) {
              selectedContactList.add(_provider.contactList[i]);
            }
          }

          if(selectedContactList.length<2){
            DialogHelper.showMessage(context, 'Select at least two members');
          }else{
            Navigator.pushNamed(context, RouteConstants.group_subject,
                arguments: selectedContactList);
          }


        },
        elevation: 0.0,
        child: new Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        backgroundColor: CommonColors.primaryColor,
      ),
    );
  }
}
