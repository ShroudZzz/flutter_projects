import 'dart:ui';

import 'package:flutter/material.dart';

class FlutterLayoutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterLayoutPageState();
}

class _FlutterLayoutPageState extends State<FlutterLayoutPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'Flutter Layout',
      //theme: ThemeData(primarySwatch: Colors.blue,),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Layout'),
          leading: GestureDetector(onTap: () {
          Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Text('Click'),
        ),
        body: _currentIndex == 0
            ? RefreshIndicator(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                      'http://www.devio.org/img/avatar.png'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Opacity(
                                      opacity: 0.6,
                                      child: Image.network(
                                        'http://www.devio.org/img/avatar.png',
                                        width: 100,
                                        height: 100,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Image.network('http://www.devio.org/img/avatar.png',
                              width: 100, height: 100),
                          TextField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  hintText: 'Input',
                                  hintStyle: textStyle)),
                          Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: PhysicalModel(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              clipBehavior: Clip.antiAlias,
                              child: PageView(
                                children: [
                                  _item('Page1', Colors.deepPurple),
                                  _item('Page2', Colors.grey),
                                  _item('Page3', Colors.green),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              FractionallySizedBox(
                                widthFactor: 0.5,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.greenAccent),
                                  child: Text('kkk'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Image.network('http://www.devio.org/img/avatar.png',
                            width: 100, height: 100),
                        Positioned(
                            child: Image.network(
                                'http://www.devio.org/img/avatar.png',
                                width: 30,
                                height: 30),
                            left: 0,
                            bottom: 0)
                      ],
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _chip('Flutter'),
                        _chip('Layout'),
                        _chip('Wrap'),
                        _chip('Widget'),
                        _chip('Ok'),
                      ],
                    ),
                  ],
                ),
                onRefresh: _handleRefresh)
            : Column(
                children: [
                  Text('List'),
                  Expanded(
                    flex: 1,
                      child: Container(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Text('拉伸填满高度'),
                  ))
                ],
              ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.list,
                    color: Colors.blue,
                  ),
                  label: 'List'),
            ]),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 100));
    return null;
  }

  _item(String s, Color color) {
    return Container(
      decoration: BoxDecoration(color: color),
      alignment: Alignment.center,
      child: Text(s, style: TextStyle(fontSize: 22, color: Colors.white)),
    );
  }

  _chip(String s) {
    return Chip(
        label: Text(s),
        avatar: CircleAvatar(
          backgroundColor: Colors.blue.shade900,
          child: Text(s.substring(0, 1), style: TextStyle(fontSize: 10)),
        ));
  }
}
