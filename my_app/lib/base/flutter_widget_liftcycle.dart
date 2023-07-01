
import 'package:flutter/material.dart';

/*
 StatelessWidget - 1.createElement 2.build 两个生命周期

 StatefulWidget

 1. 初始化时期
 createState initState

 2.更新时期
 didChangeDepandencies build didUpdateWidget

 3.销毁时期
 deactivate dispose

*/

class WidgetLiftcycle extends StatefulWidget {
  const WidgetLiftcycle({super.key});

  @override
  State<WidgetLiftcycle> createState() => _WidgetLiftcycleState();
}

class _WidgetLiftcycleState extends State<WidgetLiftcycle> {

  @override
  void initState() {
    print('----initState----');
    super.initState();
  }

  /*1.init 之后立即调用  2.如果依赖于InheritedWidget，当前的State所依赖InherutedWidget中的变量改变时会再次调用*/
  @override
  void didChangeDependencies() {
    print('----didChangeDepandencies----');
    super.didChangeDependencies();
  }

  /*1.didChangeDependencies 后立即调用  2.setState或会再次调用*/
  @override
  Widget build(BuildContext context) {
    print('----build----');
    return const Placeholder();
  }

  /*父组件重新绘制时才会调用*/
  @override
  void didUpdateWidget(covariant WidgetLiftcycle oldWidget) {
    print('----didUpdateWidget----');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('----deactivate----');
    super.deactivate();
  }

  /*资源释放工作*/
  @override
  void dispose() {
    print('----dispose----');
    super.dispose();
  }
}
