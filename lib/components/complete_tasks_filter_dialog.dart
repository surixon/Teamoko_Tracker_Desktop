// @dart=2.9
import 'package:desk/provider/done_tasks_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteTasksFilterDialog extends StatefulWidget {
  final DoneTaskProvider provider;

  const CompleteTasksFilterDialog({Key key, this.provider})
      : super(key: key);

  @override
  _CompleteTasksFilterDialogState createState() => _CompleteTasksFilterDialogState();
}

enum SortBy { none, completed, rejected,cancelled }


class _CompleteTasksFilterDialogState extends State<CompleteTasksFilterDialog> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  SortBy _sortBy;


  void applyFilter(){
    Navigator.pop(context);
    widget.provider.sortBy = _sortBy.index;
    widget.provider.getDoneTask(
        context,
        sharedPreferences.getString(userId),
        widget.provider.sortBy==0?'':widget.provider.sortBy.toString(),
        sharedPreferences.getString(phoneNumber),
        '1',
        sharedPreferences.getString(companyId),
        "");
  }

  @override
  void initState() {
    super.initState();
    _sortBy = SortBy.values[widget.provider.sortBy];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 300.0,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.sort,
                    color: CommonColors.primaryColor,
                  ),
                  Text(
                    'Sort By',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black),
                  ),
                ],
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: SortBy.none,
                        groupValue: _sortBy,
                        onChanged: (SortBy value) {
                          setState(() {
                            _sortBy = value;
                            applyFilter();
                          });
                        },
                        activeColor:
                        MaterialColor(0xFFf3396a, CommonColors.color),
                      ),
                      Text(
                        'None',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.completed,
                        groupValue: _sortBy,
                        onChanged: (SortBy value) {
                          setState(() {
                            _sortBy = value;
                            applyFilter();
                          });
                        },
                        activeColor:
                        MaterialColor(0xFFf3396a, CommonColors.color),
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.rejected,
                        groupValue: _sortBy,
                        onChanged: (SortBy value) {
                          setState(() {
                            _sortBy = value;
                            applyFilter();
                          });
                        },
                        activeColor:
                        MaterialColor(0xFFf3396a, CommonColors.color),
                      ),
                      Text(
                        'Rejected',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.cancelled,
                        groupValue: _sortBy,
                        onChanged: (SortBy value) {
                          setState(() {
                            _sortBy = value;
                            applyFilter();
                          });
                        },
                        activeColor:
                        MaterialColor(0xFFf3396a, CommonColors.color),
                      ),
                      Text(
                        'Cancelled',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ), // bottom partpart
      ],
    );
  }
}
