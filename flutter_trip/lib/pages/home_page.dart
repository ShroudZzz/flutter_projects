import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

const APPBAR_SCROLL_MAX_OFFSET = 100;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _images = [
    'http://n.sinaimg.cn/sinacn10123/268/w690h378/20190729/ad95-iakuryx9023219.jpg',
    'http://n.sinaimg.cn/sinacn10123/266/w690h376/20190729/7de1-iakuryx9023260.jpg',
    'http://n.sinaimg.cn/sinacn10123/267/w690h377/20190729/7b2c-iakuryx9023343.jpg'
  ];

  double appBarAlpha = 0;

  String jsonString = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return true;
              },
              child: ListView(
                children: [
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _images.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(_images[index], fit: BoxFit.fill);
                      },
                      pagination: const SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(title: Text(jsonString)),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Home'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll(double pixels) {
    double alpha = pixels/APPBAR_SCROLL_MAX_OFFSET;
    if (alpha < 0 ) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  void _loadData() {
    HomeDao.fetch().then((value) {
      setState(() {
        jsonString = json.encode(value);
      });
    }).catchError((e) {
      jsonString = e.toString();
    });
    // try {
    //   HomeModel model = await HomeDao.fetch();
    //   setState(() {
    //     jsonString = json.encode(model);
    //   });
    // } catch(e) {
    //   jsonString = e.toString()
    // }
  }
}
