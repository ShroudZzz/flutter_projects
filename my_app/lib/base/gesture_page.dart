
import 'package:flutter/material.dart';

class GesturePage extends StatefulWidget {
  const GesturePage({super.key});

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {

  String printString = '';
  double moveX = 0, moveY = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gesture Detector'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _printMsg('Click'),
                    onDoubleTap: () => _printMsg('Double Click'),
                    onLongPress: () => _printMsg('Long Press'),
                    onTapCancel: () => _printMsg('Cancel'),
                    onTapUp: (e) => _printMsg('Tap Up'),
                    onTapDown: (e) => _printMsg('Tap Down'),
                    child: Container(
                      padding: EdgeInsets.all(60),
                      decoration: BoxDecoration(color: Colors.blueAccent),
                      child: Text('Click me', style: TextStyle(fontSize: 36, color: Colors.white)),
                    ),
                  ),
                  Text(printString)
                ],
              ),
              Positioned(left: moveX,top: moveY,
                child: GestureDetector(
                  onPanUpdate: (e) => _doMove(e),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(36)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _printMsg(String s) {
    setState(() {
      printString += ' ,${s}';
    });
  }

  _doMove(DragUpdateDetails e) {
    setState(() {
      moveY += e.delta.dy;
      moveX += e.delta.dx;
    });
  }
}


