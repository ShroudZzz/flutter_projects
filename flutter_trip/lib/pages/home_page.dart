import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart' as GridNav;
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';

const APPBAR_SCROLL_MAX_OFFSET = 100;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;

  List<CommonModel> localNavList = [];
  GridNavModel? gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel? salesBox;
  bool _loading = true;
  List<CommonModel> bannerList = [];

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false;
                  },
                  child: listView,
                ),
              ),
            ),
            _appBar,
          ],
        ),
      ),
    );
  }

  void _onScroll(double pixels) {
    double alpha = pixels / APPBAR_SCROLL_MAX_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  Widget get listView {
    return ListView(
      children: [
        _banner,
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),

        if (gridNavModel != null) Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 4), child: GridNav.GridView(gridNavModel: gridNavModel!)),

        Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),

        if (salesBox != null) Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 4), child: SalesBox(salesBox: salesBox!)),
      ],
    );
  }

  Widget get _appBar {
    return Opacity(
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
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(bannerList[index].icon ?? '',
              fit: BoxFit.fill);
        },
        pagination: const SwiperPagination(),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    HomeDao.fetch().then((value) {
      setState(() {
        localNavList = value.localNavList;
        gridNavModel = value.gridNav;
        subNavList = value.subNavList;
        salesBox = value.salesBox;
        bannerList = value.bannerList;
        _loading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _loading = false;
      });
    });
    return null;
  }
}
