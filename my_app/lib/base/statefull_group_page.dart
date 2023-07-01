import 'package:flutter/material.dart';

class StatefulGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatefulGroupState();
}

class _StatefulGroupState extends State<StatefulGroup> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'StatefulWidget 组件',
      //theme: ThemeData(primarySwatch: Colors.blue,),
      home: Scaffold(
        appBar: AppBar(
            title: Text('StatefulWidget组件'),
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
                          TextField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  hintText: 'Input',
                                  hintStyle: textStyle)),
                          Container(
                            height: 100,
                            //margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: PageView(
                              children: [
                                _item('Page1', Colors.deepPurple),
                                _item('Page2', Colors.grey),
                                _item('Page3', Colors.green),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onRefresh: _handleRefresh)
            : Text("Other Page"),
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
}
