import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/support_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketConversation extends StatefulWidget {
  String argumrnt;

  TicketConversation({this.argumrnt});

  @override
  _TicketConversationState createState() => _TicketConversationState();
}

class _TicketConversationState extends State<TicketConversation> {
  TextEditingController _textEditingController;
  SharedPreferences sharedPreferences = GetIt.instance.get();
  int page = 1;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.grey,
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
          'Ticket #' + widget.argumrnt,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<SupportProvider>(
        onModelReady: (provider) {
          provider.fetchUserChat(context, widget.argumrnt);
        },
        builder: (context, provider, _) => Container(
          child: Padding(
              padding: new EdgeInsets.only(top: statusBarHeight),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          // ignore: missing_return
                          onNotification: (ScrollNotification scrollInfo) {},
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.supportChat.length,
                              itemBuilder: (context, position) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 8.0, 10.0, 8.0),
                                        child: provider.supportChat[position]
                                            .flag ==
                                            '0'
                                            ?  Align(
                                            alignment:
                                            Alignment.centerRight,
                                            child: Container(
                                              color: CommonColors.red,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    provider
                                                        .supportChat[
                                                    position]
                                                        .message,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black,
                                                        fontSize: 13.0),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  Text(
                                                    provider
                                                        .supportChat[
                                                    position]
                                                        .created
                                                        .trim(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black,
                                                        fontSize: 13.0),
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            )
                                          )
                                            : Container(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                provider
                                                    .supportChat[
                                                position]
                                                    .message,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    color:
                                                    Colors.black,
                                                    fontSize: 13.0),
                                                maxLines: 1,
                                              ),
                                              SizedBox(
                                                height: 4.0,
                                              ),
                                              Text(
                                                provider
                                                    .supportChat[
                                                position]
                                                    .created
                                                    .trim(),
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    color:
                                                    Colors.black,
                                                    fontSize: 13.0),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          color: CommonColors.red,
                                        ),
                                      )),
                                      SizedBox(
                                        height: 12.0,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                onChanged: (_) {},
                                onSubmitted: (_) {},
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your message...',
                                  hintStyle:
                                      TextStyle(color: CommonColors.darkGrey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {
                                if (_textEditingController.text.isNotEmpty) {
                                  provider.userChat(
                                      context,
                                      widget.argumrnt,
                                      sharedPreferences.getString(userId),
                                      _textEditingController.text.toString()).then((value) {
                                        _textEditingController.text='';
                                  });
                                }
                              },
                              icon: Icon(Icons.send),
                              color: Theme.of(context).primaryColor,
                              iconSize: 35,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: provider.state == ViewState.Busy
                        ? CircularProgressIndicator()
                        : Container(),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
