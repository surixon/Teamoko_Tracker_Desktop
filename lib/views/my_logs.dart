import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/arguments_view_logs.dart';
import 'package:desk/provider/logs_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:desk/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Logs extends StatefulWidget {
  String argument="";

  Logs({this.argument});

  @override
  _LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  String startDate, endDate;
  LogsProvider _provider;

  String defaultStartDate() {
    var now = new DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  String defaultEndDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  Future<void> _showDateDangeRangePicker(BuildContext context) async {
    List<String> startDatePart = startDate.split("-");
    List<String> endtDatePart = endDate.split("-");
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        end: DateTime(int.parse(endtDatePart[2]), int.parse(endtDatePart[1]),
            int.parse(endtDatePart[0])),
        start: DateTime(int.parse(startDatePart[2]),
            int.parse(startDatePart[1]), int.parse(startDatePart[0])),
      ),
    );
    if (picked != null) {
      List<String> selectedDates = picked.toString().split(' - ');
      String selectedStartDate = selectedDates[0];
      String selectedEndDate = selectedDates[1];

      print('Start ' +
          selectedStartDate +
          '  ' +
          selectedStartDate.split(" ")[0]);
      print('End ' + selectedEndDate + ' ' + selectedEndDate.split(" ")[0]);

      startDate = Utils.getFormattedDate(selectedStartDate.split(" ")[0]);
      endDate = Utils.getFormattedDate(selectedEndDate.split(" ")[0]);

      _provider.getLogs(context, widget.argument.isNotEmpty
          ?  widget.argument
          : _sharedPreferences.getString(userId),
          _sharedPreferences.getString(companyId), startDate, endDate);
    }
  }

  @override
  void initState() {
    super.initState();
    startDate = defaultStartDate();
    endDate = defaultEndDate();
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
          "Daily Logs",
          style: TextStyle(color: Colors.black),
        ),
        leading: widget.argument!=null&&widget.argument.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                })
            : Container(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey.shade500,
            ),
            onPressed: () {
              _showDateDangeRangePicker(context);
            },
          ),
        ],
      ),
      body: BaseView<LogsProvider>(
        onModelReady: (provider) {
          _provider = provider;
          provider.getLogs(
              context,
              widget.argument!=null&& widget.argument.isNotEmpty
                  ?  widget.argument
                  :  _sharedPreferences.getString(userId),
              _sharedPreferences.getString(companyId),
              startDate,
              endDate);
        },
        builder: (context, provider, _) => Container(
          child: Padding(
              padding: new EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  provider.logsList.length==0?Center(child: Text('No logs founded please select other dates',style: TextStyle(color: Colors.black),),): Column(
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          // ignore: missing_return
                          onNotification: (ScrollNotification scrollInfo) {},
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.logsList.length,
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
                                        child: Container(
                                            child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 8.0, 10.0, 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                provider
                                                    .logsList[position].date,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                provider.logsList[position]
                                                    .workingHours,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              TextButton(
                                                child: Text("Logs",
                                                    style: TextStyle(
                                                        color:
                                                            CommonColors.red)),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RouteConstants
                                                          .view_logs_by_date,
                                                      arguments: ArgumentsViewLog(  widget.argument!=null&& widget.argument.isNotEmpty
                                                          ?  widget.argument
                                                          :  _sharedPreferences.getString(userId), provider
                                                          .logsList[position]
                                                          .date));
                                                },
                                                // shape: RoundedRectangleBorder(
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             18.0),
                                                //     side: BorderSide(
                                                //         width: 2.0,
                                                //         color:
                                                //             CommonColors.red)),
                                              ),
                                              TextButton(
                                                child: Text("Reports",
                                                    style: TextStyle(
                                                        color:
                                                            CommonColors.red)),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RouteConstants
                                                          .report_detail,
                                                      arguments:  ArgumentsViewLog( widget.argument!=null&&widget.argument.isNotEmpty
                                                          ?  widget.argument
                                                          :  _sharedPreferences.getString(userId), provider
                                                          .logsList[position]
                                                          .date));
                                                },
                                                // shape: RoundedRectangleBorder(
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             18.0),
                                                //     side: BorderSide(
                                                //         width: 2.0,
                                                //         color:
                                                //             CommonColors.red)),
                                              ),
                                            ],
                                          ),
                                        )),
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
                ],
              )),
        ),
      ),
    );
  }
}
