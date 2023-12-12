import 'package:desk/base/base_view.dart';
import 'package:desk/provider/contact_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactWithRadioButtonPage extends StatefulWidget {
  String argument;

  ContactWithRadioButtonPage({this.argument});

  @override
  _ContactWithRadioButtonPageState createState() =>
      _ContactWithRadioButtonPageState();
}

class _ContactWithRadioButtonPageState
    extends State<ContactWithRadioButtonPage> {
  int page = 1;
  int _radioValue = -1;
  ContactProvider _provider;
  final _searchContactText = TextEditingController();

  Future _loadMore(BuildContext context, ContactProvider provider) async {
    provider.myContactList(context, '0', page.toString(), '');
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  _searchContact() async {
    //API CALL ON TEXT CHANGE
    _provider.contactList=[];
    if (_searchContactText.text.trim().toString().isNotEmpty) {
      for (var i = 0; i < _provider.tempContactList.length; i++) {
        if (_provider.tempContactList[i].fullname
            .toLowerCase()
            .contains(_searchContactText.text.trim().toLowerCase())) {
          _provider.contactList.add(_provider.tempContactList[i]);
        }
      }
    } else {
      _provider.contactList.addAll(_provider.tempContactList);
    }
    setState(() {});
  }


  @override
  void initState() {
    _searchContactText.addListener(_searchContact);
    super.initState();
  }

  @override
  void dispose() {
    _searchContactText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchLeagueTextField = TextField(
      controller: _searchContactText,
      cursorWidth: 1.5,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black54,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: IconButton(
            onPressed: () {},
            color: Colors.black,
            icon: Icon(Icons.search),
          ),
          hintStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          fillColor: Colors.white),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Contacts",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.grey.shade500,
            ),
            onPressed: () {
              if (_radioValue != -1) {
                Navigator.pop(
                    context, _provider.contactList[_radioValue].contact);
              }
            },
          ),
        ],
      ),
      body: BaseView<ContactProvider>(
          onModelReady: (provider) {
            _provider = provider;
            provider.myContactList(context, '0', page.toString(), '');
          },
          builder: (context, provider, _) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: searchLeagueTextField,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
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
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.grey.shade300,
                              ),
                          shrinkWrap: true,
                          itemCount: provider.contactList.length,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Radio(
                                          value: position,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                          activeColor: MaterialColor(
                                              0xFFf3396a, CommonColors.color),
                                        ),
                                        SizedBox(
                                          width: 12,
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 18.0),
                                                maxLines: 1,
                                              ),
                                              Text(
                                                provider.contactList[position]
                                                    .designation,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                                maxLines: 1,
                                              ),
                                              Text(
                                                provider.contactList[position]
                                                    .contact,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                          }),
                    ),
                  )
                ],
              )),
    );
  }
}
