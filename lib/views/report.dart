import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/report_provider.dart';
import 'package:desk/utils/bounce_button.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  String startDate, endDate;
  final DateFormat formatter = DateFormat('dd-MM-yy');
  String _range;

  @override
  void initState() {
    _range = formatter
            .format(DateTime.now().subtract(const Duration(days: 4)))
            .toString() +
        " - " +
        formatter
            .format(DateTime.now().add(const Duration(days: 3)))
            .toString();
    startDate = _range.split(" - ")[0];
    endDate = _range.split(" - ")[1];
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd-MM-yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd-MM-yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();

        startDate = _range.split(" - ")[0];
        endDate = _range.split(" - ")[1];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text(
          "Report",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<ReportProvider>(
        onModelReady: (provider) {},
        builder: (context, provider, _) => Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 40,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Selected range: ' + _range,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 40,
                right: 0,
                bottom: 40,
                child: SfDateRangePicker(
                  selectionTextStyle: TextStyle(color: Colors.white),
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 4)),
                      DateTime.now().add(const Duration(days: 3))),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Align(
                    child: Container(
                      width: 200,
                      child: BounceButton(
                          isLoading:
                              provider.state == ViewState.Busy ? true : false,
                          onPressed: () {
                            provider.sendReport(context, startDate, endDate);
                          },
                          text: "Get Report",
                          color: CommonColors.red,
                          textColor: Colors.white),
                    ),
                    alignment: Alignment.center,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
