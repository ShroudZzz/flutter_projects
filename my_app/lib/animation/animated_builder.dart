import 'package:flutter/material.dart';

class LogoAnimatedBuilderWidget extends StatefulWidget {
  const LogoAnimatedBuilderWidget({super.key});

  @override
  State<LogoAnimatedBuilderWidget> createState() =>
      _LogoAnimatedBuilderWidgetState();
}

class _LogoAnimatedBuilderWidgetState extends State<LogoAnimatedBuilderWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(animation: animation, child: LogoWidget());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({required this.child, required this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        height: animation.value,
        width: animation.value,
        child: child,
      ),
      child: child,
    ));
  }
}
