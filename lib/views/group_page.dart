import 'package:desk/base/base_view.dart';
import 'package:desk/provider/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  int page = 1;


  Future _loadMore(BuildContext context, ContactProvider provider) async {
    provider.myGroupList(context, '1', page.toString(), '');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactProvider>(
        onModelReady: (provider) {
          provider.myGroupList(context, '1', page.toString(), '');
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
                itemCount: provider.groupList.length,
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {},
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
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  24)),
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.green,
                                              style: BorderStyle
                                                  .solid)),
                                      child: Center(
                                        child: Text(
                                          "AK",
                                          style: TextStyle(
                                              color: Colors.black),
                                        ),
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
                                                .groupList[position]
                                                .groupName,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 18.0),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            provider
                                                .groupList[position]
                                                .groupName,
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
