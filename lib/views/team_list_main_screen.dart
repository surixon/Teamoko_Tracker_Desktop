import 'package:desk/base/base_view.dart';
import 'package:desk/provider/team_provider.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/views/team_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'group_list_screen.dart';
import 'inactive_team_list_screen.dart';

class TeamListMainScreen extends StatefulWidget {
  @override
  TeamListMainScreenState createState() => TeamListMainScreenState();
}

class TeamListMainScreenState extends State<TeamListMainScreen> {
  @override
  Widget build(BuildContext context) {
    return _TabsNonScrollable();
  }
}

class _TabsNonScrollable extends StatefulWidget {
  @override
  _TabsNonScrollableState createState() => _TabsNonScrollableState();
}

class _TabsNonScrollableState extends State<_TabsNonScrollable>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController _tabController;
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  final RestorableInt tabIndex = RestorableInt(0);

  int page = 1;

  @override
  String get restorationId => 'tab_non_scrollable';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
  }

  @override
  void initState() {
    final tabs = [
      'Team',
      'Group',
      if (_sharedPreferences.getString(userType) == '3' ||
          _sharedPreferences.getString(userType) == '4')
        'InActive',
    ];
    _tabController = TabController(
      initialIndex: 0,
      length: tabs.length,
      vsync: this,
    );
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensures that the tab controller's index is updated with the
    // state restorable tab index value.
    if (_tabController.index != tabIndex.value) {
      _tabController.index = tabIndex.value;
    }



    return Scaffold(
        backgroundColor: Colors.white,
        appBar: TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          isScrollable: false,
          tabs: [
            Tab(text: 'Team'),
            Tab(text: 'Group'),
            if (_sharedPreferences.getString(userType) == '3' ||
                _sharedPreferences.getString(userType) == '4')
              Tab(text: 'InActive'),
          ],
        ),
        body: BaseView<TeamProvider>(
          onModelReady: (provider) {},
          builder: (context, provider, _) => TabBarView(
            controller: _tabController,
            children: [
              TeamListScreen(),
              GroupListScreen(),
              if (_sharedPreferences.getString(userType) == '3' ||
                  _sharedPreferences.getString(userType) == '4')
              InactiveTaskListScreen()],
          ),
        ));
  }
}
