import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {

  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  final Uri toLaunch =
  Uri(scheme: 'https', host: 'www.baidu.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Launch 3rd'),
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
            ElevatedButton(onPressed: () => setState(() {
              _launched = _launchInBrowser(toLaunch);
            }), child: Text('Launch in browser'))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
