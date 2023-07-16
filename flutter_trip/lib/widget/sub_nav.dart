import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({super.key, required this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in subNavList) {
      items.add(_item(context, model));
    }

    int seprate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(0, seprate)),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(seprate, subNavList.length),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) => WebView()));
          },
          child: Column(
            children: [
              Image.network(
                model.icon ?? '',
                width: 18,
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(model.title ?? '',
                    style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ));
  }
}
