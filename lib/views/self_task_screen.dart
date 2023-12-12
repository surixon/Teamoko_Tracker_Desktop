import 'dart:async';

import 'package:desk/base/base_view.dart';
import 'package:desk/components/self_tasks_filter_dialog.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/provider/tasks_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfTaskScreen extends StatefulWidget {
  SelfTaskScreen({Key key}) : super(key: key);

  @override
  _SelfTaskScreenState createState() => _SelfTaskScreenState();
}

class _SelfTaskScreenState extends State<SelfTaskScreen> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  int page = 1;
  TaskProvider _provider;
  Timer searchTime;
  TextEditingController _searchTextEditController;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future _loadMore(BuildContext context, TaskProvider provider) async {
    provider.selfTask(
        context,
        sharedPreferences.getString(userId),
        _provider.selfSortBy == 0 ? "" : _provider.selfSortBy.toString(),
        sharedPreferences.getString(phoneNumber),
        page.toString(),
        "");
  }

  Text _setPriority(String priority) {
    if (priority == "1") {
      return Text("Low",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.green,
              fontSize: 12.0));
    } else if (priority == "2") {
      return Text("Medium",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.blue,
              fontSize: 12.0));
    } else if (priority == "3") {
      return Text("High",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.primaryColor,
              fontSize: 12.0));
    } else if (priority == "4") {
      return Text("Critical",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.red,
              fontSize: 12.0));
    }
  }

  void _onRefresh() async {
    _provider.selfTask(context, sharedPreferences.getString(userId),
        _provider.selfSortBy == 0 ? "" : _provider.selfSortBy.toString(),
        sharedPreferences.getString(phoneNumber), "1", _searchTextEditController.text).then((value) {
      _refreshController.refreshCompleted();
    });


  }




  void getTaskApiCall(String searchText){
    _provider.selfTask(context, sharedPreferences.getString(userId),
        _provider.selfSortBy == 0 ? "" : _provider.selfSortBy.toString(),
        sharedPreferences.getString(phoneNumber), "1", searchText.toString());
  }

  @override
  void initState() {
    super.initState();
    _searchTextEditController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextEditController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final searchTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _searchTextEditController,
      onChanged: (value){
        if(value.trim().isEmpty)
          return;

        const duration =  Duration(microseconds: 800);
        if(searchTime!=null){
          setState(() {
            searchTime.cancel();
          });
        }
        setState(() {
          searchTime= new Timer(duration, (){
            getTaskApiCall(value);
          });
        });

      },
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
      ),
    );

    return BaseView<TaskProvider>(
      onModelReady: (provider) {
        _provider = provider;
        provider.selfTask(context, sharedPreferences.getString(userId),   _provider.selfSortBy == 0 ? "" : _provider.selfSortBy.toString(),
            sharedPreferences.getString(phoneNumber), page.toString(), "");
      },
      builder: (context, provider, _) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.white,
          title: _provider.showSearchBar?Text(
            "Self",
            style: TextStyle(color: Colors.black),
          ):searchTextField,
          actions: [
            SizedBox(
              width: 8.0,
            ),
            _provider.showSearchBar
                ? GestureDetector(
              onTap: () {
                _searchTextEditController.text='';
                _provider.updateSeachBar(false);
              },
              child: ImageIcon(
                AssetImage("assets/images/ic_search.png"),
                size: 24.0,
                color: Colors.grey,
              ),
            )
                : GestureDetector(
              onTap: () {
                _searchTextEditController.text='';
                _provider.updateSeachBar(true);
              },
              child: ImageIcon(
                AssetImage("assets/images/ic_cross.png"),
                size: 20.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SelfTasksFilterDialog(provider: _provider);
                    });
              },
              child: ImageIcon(
                AssetImage("assets/images/ic_filter.png"),
                size: 24.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
        body: Container(
          child: Padding(
              padding: new EdgeInsets.only(top: statusBarHeight),
              child: Stack(
                children: [
                  _provider.selfTaskList.length==0?Center(
                      child: Text('No tasks created yet',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                  ):Column(
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          // ignore: missing_return
                          onNotification: (ScrollNotification scrollInfo) {
                            if (page < provider.lastPage &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              setState(() {
                                page = page + 1;
                              });
                              _loadMore(context, provider);
                            }
                          },
                          child: SmartRefresher(
                            enablePullDown: true,
                            header: WaterDropHeader(),
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: provider.selfTaskList.length,
                                itemBuilder: (context, position) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteConstants.task_details,
                                          arguments: provider
                                              .selfTaskList[position].eventId);
                                    },
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
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      children: [
                                                        Center(
                                                          child: CircleAvatar(
                                                            radius: 24,
                                                            backgroundImage:
                                                            NetworkImage(provider
                                                                .selfTaskList[
                                                            position]
                                                                .ppThumbnail),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4.0,
                                                        ),
                                                        Text(
                                                          "# " +
                                                              provider
                                                                  .selfTaskList[
                                                              position]
                                                                  .eventId,
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.black,
                                                              fontSize: 13.0),
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            provider
                                                                .selfTaskList[
                                                            position]
                                                                .eventName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors.black,
                                                                fontSize: 18.0),
                                                            maxLines: 1,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text('Self',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 12.0))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                            provider
                                                                .selfTaskList[
                                                            position]
                                                                .date
                                                                .split(" ")[0],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors.black,
                                                                fontSize: 12.0)),
                                                        _setPriority(provider
                                                            .selfTaskList[position]
                                                            .priority),
                                                      ],
                                                    )
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
