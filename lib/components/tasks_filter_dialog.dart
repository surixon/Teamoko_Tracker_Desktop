// @dart=2.9
import 'package:desk/provider/tasks_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksFilterDialog extends StatefulWidget {
  final TaskProvider provider;

  const TasksFilterDialog({Key key, this.provider}) : super(key: key);

  @override
  _TasksFilterDialogState createState() => _TasksFilterDialogState();
}

enum SortBy { both, send, received }

enum FilterBy {
  none,
  distance,
  dueDate,
  priority,
  title,
  accepted,
  pending,
  reOpen,
  createDate
}

class _TasksFilterDialogState extends State<TasksFilterDialog> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  SortBy _sortBy;
  FilterBy _filterBy;

  @override
  void initState() {
    super.initState();
    _sortBy = SortBy.values[widget.provider.sortBy - 1];
    _filterBy = FilterBy.values[widget.provider.filterBy - 1];
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
          width: 400.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                  Row(
                    children: [
                      Icon(
                        Icons.sort,
                        color: CommonColors.primaryColor,
                      ),
                      Text(
                        'Filter',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: SortBy.both,
                            groupValue: _sortBy,
                            onChanged: (SortBy value) {
                              setState(() {
                                _sortBy = value;
                              });
                            },
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                          ),
                          Text(
                            'Both',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: SortBy.send,
                            groupValue: _sortBy,
                            onChanged: (SortBy value) {
                              setState(() {
                                _sortBy = value;
                              });
                            },
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                          ),
                          Text(
                            'Send',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: SortBy.received,
                            groupValue: _sortBy,
                            onChanged: (SortBy value) {
                              setState(() {
                                _sortBy = value;
                              });
                            },
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                          ),
                          Text(
                            'Received',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                      height: 280, child: VerticalDivider(color: Colors.black)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.none,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
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
                            value: FilterBy.distance,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
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
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.dueDate,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
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
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.priority,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
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
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.title,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
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
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.accepted,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
                              });
                            },
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                          ),
                          Text(
                            'Accepted',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.pending,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
                              });
                            },
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                          ),
                          Text(
                            'Pending',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.reOpen,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
                              });
                            },
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                          ),
                          Text(
                            'Re Open',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: FilterBy.createDate,
                            groupValue: _filterBy,
                            onChanged: (FilterBy value) {
                              setState(() {
                                _filterBy = value;
                              });
                            },
                            activeColor:
                                MaterialColor(0xFFf3396a, CommonColors.color),
                          ),
                          Text(
                            'Created Date',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Text("Cancel",
                        style: TextStyle(color: CommonColors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(18.0),
                    //     side: BorderSide(width: 2.0, color: CommonColors.red)),
                  ),
                  TextButton(
                    child: Text("Apply",
                        style: TextStyle(color: CommonColors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                      widget.provider.sortBy = _sortBy.index + 1;
                      widget.provider.filterBy = _filterBy.index + 1;
                      widget.provider.getTask(
                          context,
                          sharedPreferences.getString(userId),
                          (_sortBy.index + 1).toString(),
                          sharedPreferences.getString(phoneNumber),
                          '1',
                          (_filterBy.index + 1).toString(),
                          sharedPreferences.getString(companyId),
                          '');
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(18.0),
                    //     side: BorderSide(width: 2.0, color: CommonColors.red)),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ), // bottom partpart
      ],
    );
  }
}
