import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
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

/*
// Request
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

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