import 'package:desk/base/base_view.dart';
import 'package:desk/provider/tracked_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MyScreenTracking extends StatefulWidget {
  String argument='';

  MyScreenTracking({this.argument});

  @override
  _MyScreenTrackingState createState() => _MyScreenTrackingState();
}

class _MyScreenTrackingState extends State<MyScreenTracking> {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  TrackedProvider _provider;
  var selectedDate = '';
  var totalTrackedTime = '';
  DateTime _fromDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yy');

  Future<void> _showDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _fromDate) {
      setState(() {
        _fromDate = picked;
        selectedDate = formatter.format(_fromDate);
        print(selectedDate);
        _provider
            .trackedData(context,  widget.argument.isNotEmpty?widget.argument:_sharedPreferences.getString(userId),
                selectedDate, '1')
            .then((value) {
          if (value) {
            setState(() {
              totalTrackedTime = _provider.totalTrackedTime;
            });
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = formatter.format(_fromDate);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text(
          "Tracker",
          style: TextStyle(color: Colors.black),
        ),
        leading: widget.argument!=null&&widget.argument.isNotEmpty?IconButton(icon: Icon(Icons.close,color: Colors.black,), onPressed: (){
          Navigator.pop(context);
        }):Container(),
        actions: [
          GestureDetector(
            onTap: () {
              _showDatePicker(context);
            },
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey.shade500,
                  ),
                  onPressed: () {},
                ),
                Row(
                  children: [
                    Text(
                      selectedDate,
                      style: TextStyle(color: CommonColors.green),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      totalTrackedTime,
                      style: TextStyle(color: CommonColors.green),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      body: BaseView<TrackedProvider>(
        onModelReady: (provider) {
          _provider = provider;
          provider
              .trackedData(context, widget.argument.isNotEmpty?widget.argument:_sharedPreferences.getString(userId),
                  selectedDate, '1')
              .then((value) {
            if (value!=null&&value) {
              setState(() {
                totalTrackedTime = _provider.totalTrackedTime;
              });
            }
          });
        },
        builder: (context, provider, _) => Padding(
          padding: EdgeInsets.all(16.0),
          child: _provider.trackingDataList.length == 0
              ? Center(
                  child: Text(
                    'No available screenshots for the day',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children:
                      List.generate(_provider.trackingDataList.length, (index) {
                    print(_provider.trackingDataList[index].screenShot);
                    return Card(
                        child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Image.network(_provider
                                    .trackingDataList[index].screenShot)
                                /*CachedNetworkImage(
                          imageUrl: _provider.trackingDataList[index].screenShot,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )*/
                                ),
                            Row(
                              children: [
                                Text(
                                  _provider.trackingDataList[index].time,
                                ),
                                Expanded(
                                    child: StepProgressIndicator(
                                  totalSteps: 10,
                                  currentStep: int.parse(_provider
                                      .trackingDataList[index].progressRank),
                                  size: 10,
                                  selectedColor: CommonColors.green,
                                  unselectedColor: Colors.grey,
                                )),
                              ],
                            )
                          ]),
                    ));
                  }),
                ),
        ),
      ),
    );
  }
}
