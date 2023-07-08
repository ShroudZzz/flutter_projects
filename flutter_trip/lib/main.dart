import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_trip/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TabNavigator(),
    );
  }
}

// Request
/*
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
*/

// Future && Model
/*
class _MyAppState extends State<MyApp> {
  String showResult = '';

  Future<CommonModel> fetchPost() async {
    final url = Uri.https(
        'www.devio.org', '/io/flutter_app/json/test_common_model.json');
    final response = await http.get(url);
    final utf8Decoder = Utf8Decoder();
    final result = json.decode(utf8Decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  /* request, async/await
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http'),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                fetchPost().then((value) {
                  setState(() {
                    showResult = 'Request: \nhideAppBar: ${value.hideAppBar}';
                  });
                });
              },
              child: const Text('click', style: TextStyle(fontSize: 26)),
            ),
            Text(showResult),
          ],
        ),
      ),
    );
  }
   */

  //FutureBuilder
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http'),
        ),
        body: FutureBuilder<CommonModel>(
          future: fetchPost(),
          builder: (context, snapsShot) {
            switch (snapsShot.connectionState) {
              case ConnectionState.none:
                return Text('Start');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('');
              case ConnectionState.done:
                if (snapsShot.hasError) {
                  return Text(
                    '${snapsShot.error}',
                  );
                } else {
                  return Column(
                    children: [
                      Text('icon : ${snapsShot.data?.icon}'),
                      Text('color : ${snapsShot.data?.statusBarColor}'),
                      Text('title : ${snapsShot.data?.title}'),
                      Text('url : ${snapsShot.data?.url}'),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar);

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(json['icon'], json['title'], json['url'],
        json['statusBarColor'], json['hideAppBar']);
  }
}
*/

// shared_preferences use
/*
class _MyAppState extends State<MyApp> {
  String countString = '';
  String localCount = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Use',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SharedPreferences'),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: () => _incrementCounter(), child: Text('Counter')),
            Text(countString, style: TextStyle(fontSize: 20)),
            ElevatedButton(onPressed: () => _getCounter(), child: Text('Get Counter')),
            Text(localCount, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),

    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countString = '${countString} 1';
    });
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt('counter').toString();
    });
  }
}
 */

//ListView
/*
const CITY_NAMES = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('ListView')),
        body: ListView(
          //scrollDirection: Axis.horizontal,
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  //item Set Width not work, should be set in  ListView
  Widget _item(String city) {
    return Container(
      height: 80,
      //width: 80, not work
      margin: EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(city, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
*/

//ExpansionTile
/*
const CITY_NAMES = {
  '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
  '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
  '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
  '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
  '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
  '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text('ListView')),
          body: ListView(
            children: _buildList(),
          )
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    CITY_NAMES.keys.forEach((key) {
      widgets.add(_item(key, CITY_NAMES[key] ?? []));
    });
    return widgets;
  }

  Widget _item(String city, List<String> subCities) {
    return ExpansionTile(
        title: Text(city, style: TextStyle(color: Colors.black54, fontSize: 30)),
        children: subCities.map((e) => _buildSub(e)).toList(),
    );
  }

  Widget _buildSub(String subCity) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(subCity),
      ),
    );
  }
}
*/

//GridView
/*
const CITY_NAMES = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView',
      home: Scaffold(
        appBar: AppBar(
          title: Text('GridView'),
        ),
        body: GridView.count(
          crossAxisCount: 6,
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

*/

//Refresh
/*
List<String> cityNames = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refresh',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Refresh'),
          ),
          body: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView(
              controller: _scrollController,
              children: _buildList(),
            ),
          )
      ),
    );
  }

  _loadData() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      //copy
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
    return null;
  }

  List<Widget> _buildList() {
    return cityNames.map((e) => _buildItem(e)).toList();
  }

  Widget _buildItem(String e) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(e,style: TextStyle(color: Colors.white,fontSize: 20)),
    );
  }
}
 */