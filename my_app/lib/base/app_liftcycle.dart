
import 'package:flutter/material.dart';

/*
* WidgetBindingObserver ： Widgets绑定观察器，通过它可以监听应用的生命周期
*
* */

class AppLifecycle extends StatefulWidget {
  const AppLifecycle({super.key});

  @override
  State<AppLifecycle> createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if (state == AppLifecycleState.paused) {
      print('App 进入后台');
    } else if (state == AppLifecycleState.resumed){
      print('App 进入前台');
    } else if (state == AppLifecycleState.inactive){
      //App 位于非活动状态 比如电话
    } else if (state == AppLifecycleState.detached){
      //Flutter engine
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
