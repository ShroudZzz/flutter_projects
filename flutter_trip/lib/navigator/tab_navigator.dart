import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _controller = PageController(
    initialPage: 0,
  );

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [HomePage(), SearchPage(hideLeft: true), TravelPage(), MyPage()],
        physics: const NeverScrollableScrollPhysics(), //禁止底部Tab滚动
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _defaultColor),
                activeIcon: Icon(Icons.home, color: _activeColor),
                label: 'Home',
                backgroundColor:
                    _currentIndex != 0 ? _defaultColor : _activeColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _defaultColor),
                activeIcon: Icon(Icons.search, color: _activeColor),
                label: 'Search',
                backgroundColor:
                    _currentIndex != 1 ? _defaultColor : _activeColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt, color: _defaultColor),
                activeIcon: Icon(Icons.camera_alt, color: _activeColor),
                label: 'Travel',
                backgroundColor:
                    _currentIndex != 2 ? _defaultColor : _activeColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _defaultColor),
                activeIcon: Icon(Icons.account_circle, color: _activeColor),
                label: 'My',
                backgroundColor:
                    _currentIndex != 3 ? _defaultColor : _activeColor),
          ]),
    );
  }
}
