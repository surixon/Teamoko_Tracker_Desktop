import 'package:desk/base/base_view.dart';
import 'package:desk/model/arguments_contact_list_to_add_task.dart';
import 'package:desk/provider/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  int page = 1;

  Future _loadMore(BuildContext context, ContactProvider provider) async {
    provider.myContactList(context, '0', page.toString(), '');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactProvider>(
        onModelReady: (provider) {
          provider.myContactList(context, '0', page.toString(), '');
        },
        builder: (context, provider, _) => Expanded(
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
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: provider.contactList.length,
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context,DataContactListToAddTask('SINGLE',provider.contactList[position].fullname,provider.contactList[position].contact));
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4.0,
                        ),
                        Card(
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(4.0),
                          ),
                          child: Container(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10.0, 8.0, 10.0, 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: CircleAvatar(
                                        radius: 24,
                                        backgroundImage:
                                        NetworkImage(provider
                                            .contactList[
                                        position]
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
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            provider
                                                .contactList[position]
                                                .fullname,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 18.0),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            provider
                                                .contactList[position]
                                                .designation,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 14.0),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            provider
                                                .contactList[position]
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
                        ),
                        SizedBox(
                          height: 4.0,
                        )
                      ],
                    ),
                  );
                }),
          ),
        ));
  }
}
