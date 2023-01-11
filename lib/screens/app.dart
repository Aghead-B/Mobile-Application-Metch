import 'package:flutter/material.dart';
import 'package:metch/screens/tab_navigator.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {
  String _currentPage = "HomePage";
  List<String> pageKeys = ["HomePage", "FindMatchPage", "SetupMatchScreen"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "HomePage": GlobalKey<NavigatorState>(),
    "FindMatchPage": GlobalKey<NavigatorState>(),
    "SetupMatchScreen": GlobalKey<NavigatorState>(),
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
            _buildOffstageNavigator("FindMatchPage"),
            _buildOffstageNavigator("SetupMatchScreen"),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff2e8d89), Color(0xff000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            onTap: (int index) {
              _selectTab(pageKeys[index], index);
            },
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home,
                      color: bottomNavigationBarIcon,
                      size: 35,
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: bottomNavigationBarIcon,
                    size: 35,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: bottomNavigationBarIcon,
                    size: 35,
                  ),
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
