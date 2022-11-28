import 'package:flutter/material.dart';
import 'package:metch/pages/home_page.dart';
import 'package:metch/pages/my_match_page.dart';
import 'package:metch/pages/setup_match_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    late Widget child ;
    if(tabItem == "HomePage") {
      child = const HomePage();
    } else if(tabItem == "FindMatchPage") {
      child = const MyMatchPage();
    } else if(tabItem == "SetupMatchPage") {
      child = const SetupMatchPage();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}