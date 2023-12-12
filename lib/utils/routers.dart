import 'package:desk/utils/route_constants.dart';
import 'package:desk/views/add_task_page.dart';
import 'package:desk/views/all_task.dart';
import 'package:desk/views/change_password.dart';
import 'package:desk/views/chat.dart';
import 'package:desk/views/contact_list_screen.dart';
import 'package:desk/views/contact_page_with_radio.dart';
import 'package:desk/views/login_screen.dart';
import 'package:desk/views/main_scaffold.dart';
import 'package:desk/views/our_done_task_screen.dart';
import 'package:desk/views/forgot_password.dart';
import 'package:desk/views/group_subject.dart';
import 'package:desk/views/my_logs.dart';
import 'package:desk/views/my_screen_tracker.dart';
import 'package:desk/views/new_group_screen.dart';
import 'package:desk/views/our_task.dart';
import 'package:desk/views/profile_screen.dart';
import 'package:desk/views/report_detail_page.dart';
import 'package:desk/views/self_task_screen.dart';
import 'package:desk/views/task_detail_screen.dart';
import 'package:desk/views/ticket_conversation.dart';
import 'package:desk/views/ticket_status.dart';
import 'package:desk/views/view_logs_by_date.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.login:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);

      case RouteConstants.main:
        return MaterialPageRoute(
            builder: (_) => MainScaffold(), settings: settings);

      case RouteConstants.chat:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ChatScreen(arguments: arguments),
            settings: settings);

      case RouteConstants.task_details:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => TaskDetailScreen(arguments: arguments),
            settings: settings);

      case RouteConstants.add_task:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AddTaskPage(arguments: arguments),
            settings: settings);

      case RouteConstants.profile:
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(), settings: settings);

      case RouteConstants.contact_list:
        return MaterialPageRoute(
            builder: (_) => ContactListScreen(), settings: settings);

      case RouteConstants.all_task:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AllTaskScreen(taskScreenArguments: arguments),
            settings: settings);

      case RouteConstants.our_task:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => OurTaskScreen(
                  ourTaskScreenArguments: arguments,
                ),
            settings: settings);

      case RouteConstants.our_done_task:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => OurDoneTaskScreen(
                  doneTaskScreenArguments: arguments,
                ),
            settings: settings);

      case RouteConstants.new_group:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => NewGroupScreen(), settings: settings);

      case RouteConstants.group_subject:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => GroupSubject(argumrntList: arguments),
            settings: settings);

      case RouteConstants.self_task:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => SelfTaskScreen(), settings: settings);
      case RouteConstants.change_password:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ChangePassword(), settings: settings);

      case RouteConstants.ticket_status:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => TicketStatus(), settings: settings);

      case RouteConstants.ticket_conversation:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => TicketConversation(
                  argumrnt: arguments,
                ),
            settings: settings);

      case RouteConstants.forgot_password:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ForgotPassword(), settings: settings);

      case RouteConstants.view_logs_by_date:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ViewLogsByDate(
                  argument: arguments,
                ),
            settings: settings);

      case RouteConstants.report_detail:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ReportDetailScreen(
                  argument: arguments,
                ),
            settings: settings);

      case RouteConstants.logs:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Logs(
                  argument: arguments,
                ),
            settings: settings);

      case RouteConstants.screen_tracker:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MyScreenTracking(
                  argument: arguments,
                ),
            settings: settings);

      case RouteConstants.contact_with_radio_button:
        var arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ContactWithRadioButtonPage(argument: arguments,), settings: settings);
    }
  }
}
