// @dart=2.9
import 'dart:io';

import 'package:desk/data/socket_io_manager.dart';
import 'package:desk/provider/add_task_provider.dart';
import 'package:desk/provider/change_password_provider.dart';
import 'package:desk/provider/contact_provider.dart';
import 'package:desk/provider/daily_provider.dart';
import 'package:desk/provider/done_tasks_provider.dart';
import 'package:desk/provider/group_provider.dart';
import 'package:desk/provider/invite_provider.dart';
import 'package:desk/provider/login_provider.dart';
import 'package:desk/provider/logs_provider.dart';
import 'package:desk/provider/main_provider.dart';
import 'package:desk/provider/messages_provider.dart';
import 'package:desk/provider/our_task_provider.dart';
import 'package:desk/provider/profile_provider.dart';
import 'package:desk/provider/report_provider.dart';
import 'package:desk/provider/support_provider.dart';
import 'package:desk/provider/task_detail_provider.dart';
import 'package:desk/provider/tasks_provider.dart';
import 'package:desk/provider/team_provider.dart';
import 'package:desk/provider/tracked_provider.dart';
import 'package:desk/theme.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/routers.dart';
import 'package:desk/views/login_screen.dart';
import 'package:desk/views/main_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';

import 'api/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SocketIoManager socketIoManager = SocketIoManager();
  GetIt.instance.registerSingleton(sharedPreferences);
  GetIt.instance.registerSingleton(socketIoManager);
  SocketIoManager socketIoMgr = GetIt.instance.get();
  socketIoMgr.connectSocket();
  GetIt.instance.registerSingleton(ApiClient());
  GetIt.instance.registerFactory<LoginProvider>(() => LoginProvider());
  GetIt.instance
      .registerFactory<ChangePasswordProvider>(() => ChangePasswordProvider());
  GetIt.instance.registerFactory<SupportProvider>(() => SupportProvider());
  GetIt.instance.registerFactory<ReportProvider>(() => ReportProvider());
  GetIt.instance.registerFactory<TrackedProvider>(() => TrackedProvider());
  GetIt.instance.registerFactory<LogsProvider>(() => LogsProvider());
  GetIt.instance.registerFactory<TaskProvider>(() => TaskProvider());
  GetIt.instance.registerFactory<DailyProvider>(() => DailyProvider());
  GetIt.instance.registerFactory<DoneTaskProvider>(() => DoneTaskProvider());
  GetIt.instance
      .registerFactory<TaskDetailProvider>(() => TaskDetailProvider());
  GetIt.instance.registerFactory<TeamProvider>(() => TeamProvider());
  GetIt.instance.registerFactory<MainProvider>(() => MainProvider());
  GetIt.instance.registerFactory<MessagesProvider>(() => MessagesProvider());
  GetIt.instance.registerFactory<ProfileProvider>(() => ProfileProvider());
  GetIt.instance.registerFactory<AddTaskProvider>(() => AddTaskProvider());
  GetIt.instance.registerFactory<ContactProvider>(() => ContactProvider());
  GetIt.instance.registerFactory<OurTaskProvider>(() => OurTaskProvider());
  GetIt.instance.registerFactory<GroupProvider>(() => GroupProvider());
  GetIt.instance.registerFactory<InviteProvider>(() => InviteProvider());

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Teamoko');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var isLogged = _sharedPreferences.getString(userId) != null;
    return MaterialApp(
      title: 'Teamoko',
      theme: darkTheme(),
      debugShowCheckedModeBanner: false,
      home: /* FilePickerDemo()*/
          isLogged ? MainScaffold() : LoginScreen() /*ScreenShotPage()*/,
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
