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

class ReportDetailScreen extends StatefulWidget {
  ArgumentsViewLog argument;

  ReportDetailScreen({this.argument});

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Report',
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
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.view_logs_by_date,arguments: widget.argument);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Logs',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
      body: BaseView<LogsProvider>(
        onModelReady: (provider) {
          _provider = provider;
          _provider.dailyReportDetail(
              context,
              widget.argument.userId,
              widget.argument.date,
              _sharedPreferences.getString(companyId));
        },
        builder: (context, provider, _) => Container(
          color: Colors.white,
          child: Padding(
              padding: new EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Name :',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Designation :',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Employee Id :',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Date :',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Total Number of\nHours :',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                '',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
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
