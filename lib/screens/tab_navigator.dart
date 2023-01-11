import 'package:flutter/material.dart';
import 'package:metch/screens/home_screen_version1.dart';
import 'package:metch/screens/setup_match_screen.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (tabItem == "HomePage") {
      child = const HomeScreenVersion1();
    } else if (tabItem == "SetupMatchScreen") {
      child = const SetupMatchScreen();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
