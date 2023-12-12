import 'package:desk/base/base_view.dart';
import 'package:desk/provider/contact_provider.dart';
import 'package:desk/views/contact_page.dart';
import 'package:desk/views/group_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  @override
  ContactListScreenState createState() => ContactListScreenState();
}

class ContactListScreenState extends State<ContactListScreen> {
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
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
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

    final tabs = [
      'Team',
      'Group',
    ];

    return Scaffold(
      backgroundColor: Colors.grey,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Contacts",
              style: TextStyle(color: Colors.black),
            ),
            bottom: TabBar(
              labelColor: Colors.black,
              controller: _tabController,
              isScrollable: false,
              tabs: [
                  Tab(text: 'Team'),
                  Tab(text: 'Group'),
              ],
            )),
        body: BaseView<ContactProvider>(
          onModelReady: (provider) {

          },
          builder: (context, provider, _) => TabBarView(
            controller: _tabController,
            children: [
                ContactPage(),
                GroupPage(),
            ],
          ),
        ));
  }
}
