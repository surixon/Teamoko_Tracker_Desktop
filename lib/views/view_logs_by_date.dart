import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/arguments_view_logs.dart';
import 'package:desk/provider/logs_provider.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewLogsByDate extends StatefulWidget {
  ArgumentsViewLog argument;

  ViewLogsByDate({this.argument});

  @override
  _ViewLogsByDateState createState() => _ViewLogsByDateState();
}

class _ViewLogsByDateState extends State<ViewLogsByDate> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  LogsProvider _provider;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text(
          widget.argument.date,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteConstants.report_detail,arguments: widget.argument);
            },
            child: Align(alignment: Alignment.centerRight,
              child: Text('Status',style: TextStyle(color: Colors.black),),),
          )
        ],
      ),
      body: BaseView<LogsProvider>(
        onModelReady: (provider) {
          _provider = provider;
          _provider.viewLogsByDate(
              context,
              widget.argument.userId,
              widget.argument.date,
              _sharedPreferences.getString(companyId));
        },
        builder: (context, provider, _) => Container(
          child: Padding(
              padding: new EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                       Text('S.No.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),),
                       Text('CheckIn',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),),
                       Text('CheckOut',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),),
                       Text('Time',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),),
                      ],),
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          // ignore: missing_return
                          onNotification: (ScrollNotification scrollInfo) {},
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.checkIn.length,
                              itemBuilder: (context, position) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        elevation: 4,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text((position+1).toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),),
                                              Text(_provider.checkIn[position],style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16.0),),
                                              Text(_provider.checkOut[position],style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16.0),),
                                              Text(_provider.interval[position],style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16.0),),
                                            ],),
                                        )
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      )
                                    ],
                                  ),
                                );
                              }),
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

                  Align(alignment: Alignment.bottomRight,
                  child: Text('Total Working Hours : '+_provider.totalWorkingHours),)
                ],
              )),
        ),
      ),
    );
  }
}
