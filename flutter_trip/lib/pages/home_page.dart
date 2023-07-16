//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
//import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/speak_page.dart';
import 'package:flutter_trip/widget/grid_nav.dart' as GridNav;
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/search_bar.dart' as CSearchBar;

const APPBAR_SCROLL_MAX_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

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
    //启动屏
    Future.delayed(const Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
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
        if (gridNavModel != null)
          Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
              child: GridNav.GridView(gridNavModel: gridNavModel!)),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        if (salesBox != null)
          Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
              child: SalesBox(salesBox: salesBox!)),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
            ),
            child: CSearchBar.SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? CSearchBar.SearchBarType.homeLight
                  : CSearchBar.SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  Widget get _banner {
    return SizedBox(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(bannerList[index].icon ?? '', fit: BoxFit.fill);
        },
        pagination: const SwiperPagination(),
      ),
    );
  }

  Future<void> _handleRefresh() async {
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
      setState(() {
        _loading = false;
      });
    });
    return;
  }

  void _jumpToSpeak() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SpeakPage();
    }));
  }

  void _jumpToSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT);
    }));
  }
}
