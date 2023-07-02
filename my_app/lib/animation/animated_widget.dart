import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  AnimationStatus? animationStatus;
  double? animationValue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
    /*
    animation.addListener((){
      setState(() {
        animationValue = animation.value;
      });
    });
    animation.addStatusListener ((AnimationStatus state) {
      setState(() {
        animationStatus = state;
      });
    });
    */
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Text('Start', textDirection: TextDirection.ltr),
          ),
          Text('State: ' + animationStatus.toString(), textDirection: TextDirection.ltr),
          Text('State: ' + animationValue.toString(), textDirection: TextDirection.ltr),
          Container(
            height: animation.value,
            width: animation.value,
              child: FlutterLogo(),
          )
        ],
      ),
    );
  }
  */
  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: animation);
  }
}
