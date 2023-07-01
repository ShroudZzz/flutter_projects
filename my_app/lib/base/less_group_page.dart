import 'package:flutter/material.dart';

class LessGroupPage extends StatelessWidget {
  const LessGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 50);

    return MaterialApp(
      title: 'StatelessWidget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text('StatelessWidget 组件'),
          leading: GestureDetector(onTap: () {
            Navigator.pop(context);
          },
              child: Icon(Icons.arrow_back)
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              const Text('I am Text', style: textStyle),
              const Icon(Icons.android, size: 50, color: Colors.green),
              const CloseButton(),
              const BackButton(),
              const Chip(
                avatar: Icon(Icons.photo),
                label: Text('StatelessWidget'),
              ),
              const Divider(height: 10, color: Colors.orange, indent: 0),
              Card(
                color: Colors.blue,
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('I am Card', style: textStyle),
                ),
              ),
              const AlertDialog(
                title: Text('Dialog'),
                content: Text('Dialog Test'),
              ),
            ],
          ),
        ),
      )
    );
  }
}