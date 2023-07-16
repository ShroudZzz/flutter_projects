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
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage(), SearchPage(hideLeft: true), TravelPage(), MyPage()], //禁止底部Tab滚动
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
            _bottomItem('Home', Icons.home, 0),
            _bottomItem('Search', Icons.search, 1),
            _bottomItem('Travel', Icons.camera_alt, 2),
            _bottomItem('My', Icons.account_circle, 3),
          ]),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
      backgroundColor: _currentIndex != index ? _defaultColor : _activeColor
    );
  }
}
