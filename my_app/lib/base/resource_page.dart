import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

class ResourcePage extends StatefulWidget {
  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Resource Use'),
        leading: GestureDetector(onTap: () {
          Navigator.pop(context);
        },
            child: Icon(Icons.arrow_back)
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Resource Use',
              style: TextStyle(color: ColorUtil.color('#a9ee00')),
            ),
            Image(image: AssetImage('images/Valorant.jpg')),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
