import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:metch/screens/tab_navigator.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class AppVersion1 extends StatefulWidget {
  const AppVersion1({Key? key}) : super(key: key);

  @override
  State<AppVersion1> createState() => _AppVersion1State();
}

class _AppVersion1State extends State<AppVersion1> {
  String _currentPage = "HomePage";
  List<String> pageKeys = ["HomePage", "SetupMatchScreen", "ProfilePage"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "HomePage": GlobalKey<NavigatorState>(),
    "SetupMatchScreen": GlobalKey<NavigatorState>(),
    "ProfilePage": GlobalKey<NavigatorState>()
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "HomePage") {
            _selectTab("HomePage", 1);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator("HomePage"),
            _buildOffstageNavigator("SetupMatchScreen"),
            _buildOffstageNavigator("ProfilePage"),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff29b3b0), Color(0xff000000)],
              // colors: [Color(0xff827e7a), Color(0xff202020)], black and gray
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BottomNavigationBar(
            iconSize: 45,
            onTap: (int index) {
              _selectTab(pageKeys[index], index);
            },
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: bottomNavigationBarIcon,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: bottomNavigationBarIcon,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: bottomNavigationBarIcon,
                ),
                label: '',
              )
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}