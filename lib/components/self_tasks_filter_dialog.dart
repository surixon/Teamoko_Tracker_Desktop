// @dart=2.9
import 'package:desk/provider/tasks_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfTasksFilterDialog extends StatefulWidget {
  final TaskProvider provider;

  const SelfTasksFilterDialog({Key key, this.provider})
      : super(key: key);

  @override
  _SelfTasksFilterDialogState createState() => _SelfTasksFilterDialogState();
}

enum SortBy { none,distance, dueDate, priority,title,createDate }

class _SelfTasksFilterDialogState extends State<SelfTasksFilterDialog> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  SortBy _sortBy;

  void applyFilter(){
    Navigator.pop(context);
    widget.provider.selfSortBy = _sortBy.index;
    widget.provider.selfTask(
        context,
        sharedPreferences.getString(userId),
        (_sortBy.index).toString()=='0'?"": (_sortBy.index).toString(),
        sharedPreferences.getString(phoneNumber),
        '1',
        '');
  }

  @override
  void initState() {
    super.initState();
    _sortBy = SortBy.values[widget.provider.selfSortBy];
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
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.distance,
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
                        'Distance',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.dueDate,
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
                        'Due Date',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.priority,
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
                        'Priority',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.title,
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
                        'Title',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Radio(
                        value: SortBy.createDate,
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
                        'Create Date',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ), // bottom partpart
      ],
    );
  }
}
