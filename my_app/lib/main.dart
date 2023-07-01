import 'package:flutter/material.dart';
import 'package:my_app/base/flutter_layout_page.dart';
import 'package:my_app/base/flutter_widget_liftcycle.dart';
import 'package:my_app/base/gesture_page.dart';
import 'package:my_app/base/launch_page.dart';
import 'package:my_app/base/less_group_page.dart';
import 'package:my_app/base/plugin_use.dart';
import 'package:my_app/base/resource_page.dart';
import 'package:my_app/base/statefull_group_page.dart';

import 'base/photo_app.dart';

void main() {
  runApp(DynamaticTheme());
}

class DynamaticTheme extends StatefulWidget {
  const DynamaticTheme({super.key});

  @override
  State<DynamaticTheme> createState() => _DynamaticThemeState();
}

class _DynamaticThemeState extends State<DynamaticTheme> {

  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          //fontFamily: '', 设置全局字体
          brightness: _brightness,
          primarySwatch:  Colors.blue
      ),
      home: Scaffold(
        //局部字体设置
        appBar: AppBar(title: Text('Route', style: TextStyle(fontFamily: ''))),
        body: Column(
          children: [
            ElevatedButton(onPressed: () => setState(() {
              _brightness = _brightness == Brightness.light ? Brightness.dark : Brightness.light;
            }), child: Text('ThemeChange')),
            RouteNavigator(title: 'Photo'),
          ],
        ),
      ),
      routes: <String, WidgetBuilder> {
        'plugin': (BuildContext context) => PluginUse(),
        'less': (BuildContext context) => LessGroupPage(),
        'ful': (BuildContext context) => StatefulGroup(),
        'layout': (BuildContext context) => FlutterLayoutPage(),
        'gesture': (BuildContext context) => GesturePage(),
        'resource': (BuildContext context) => ResourcePage(),
        'launch': (BuildContext context) => LaunchPage(),
        'lifecycle': (BuildContext context) => WidgetLiftcycle(),
        'photo': (BuildContext context) => PhotoApp(),
      },
    );
  }
}


class RouteNavigator extends StatefulWidget {
  const RouteNavigator({super.key, required this.title});
  final String title;

  @override
  State<RouteNavigator> createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  
  bool byName = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SwitchListTile(
              title: Text('${byName ? '' : 'No'} By Route Name Nav'),
              value: byName, onChanged: (value) {
            setState(() {
              byName = value;
            });
          }),
          _item('StateLess', LessGroupPage(), 'less'),
          _item('Stateful', StatefulGroup(), 'ful'),
          _item('Plugin', PluginUse(), 'plugin'),
          _item('Layout', FlutterLayoutPage(), 'layout'),
          _item('Gesture', GesturePage(), 'gesture'),
          _item('Resource', ResourcePage(), 'resource'),
          _item('Launch', LaunchPage(), 'launch'),
          _item('Lifecycle', WidgetLiftcycle(), 'lifecycle'),
          _item('PhotoApp', PhotoApp(), 'photo'),
        ],
      ),
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}