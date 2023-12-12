import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/support_provider.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketStatus extends StatefulWidget {
  TicketStatus({Key key}) : super(key: key);

  @override
  _TicketStatusState createState() => _TicketStatusState();
}

class _TicketStatusState extends State<TicketStatus> {
  SharedPreferences sharedPreferences = GetIt.instance.get();

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
          "Status",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<SupportProvider>(
        onModelReady: (provider) {
          provider.fetchTicket(context, sharedPreferences.getString(userId));
        },
        builder: (context, provider, _) => Container(
          color: Colors.white,
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
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: provider.tickets.length,
                              itemBuilder: (context, position) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, RouteConstants.ticket_conversation,arguments: provider.tickets[position].id);
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.0, 8.0, 10.0, 8.0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Ticket No- #' +
                                                            provider
                                                                .tickets[position]
                                                                .id,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 13.0),
                                                        maxLines: 1,
                                                      ),
                                                      SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      Text(
                                                        provider
                                                            .tickets[position].query
                                                            .trim(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 13.0),
                                                        maxLines: 1,
                                                      ),
                                                      SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            provider
                                                                .tickets[position]
                                                                .createdDate+" | ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors.black,
                                                                fontSize: 13.0),
                                                            maxLines: 1,
                                                          ) ,


                                                          provider.tickets[position].status=="0"?Text(
                                                           "IN PROGRESS",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors.red,
                                                                fontSize: 13.0),
                                                            maxLines: 1,
                                                          ): Text(
                                                            "RESOLVED",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors.green,
                                                                fontSize: 13.0),
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                          )),
                                    ],
                                  ),
                                );
                              }, separatorBuilder: (context, index) => Divider(
                            color: Colors.grey.shade300,
                          ),),
                        ),
                      ),
                      Container(
                        height: provider.state == ViewState.Busy ? 50.0 : 0,
                        color: Colors.transparent,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
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
