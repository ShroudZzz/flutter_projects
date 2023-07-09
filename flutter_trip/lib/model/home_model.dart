
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(this.config, this.bannerList, this.localNavList, this.subNavList, this.gridNav, this.salesBox);

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
    localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
    bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
    subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(ConfigModel.fromJson(json['config']), bannerList, localNavList, subNavList, GridNavModel.fromJson(json['gridNav']), SalesBoxModel.fromJson(json['salesBox']));
  }

  Map<String, dynamic> toJson() {
    return {
      'config': config.toJson(),
      'bannerList': bannerList.map((item) => item.toJson()).toList(),
      'localNavList': localNavList.map((item) => item.toJson()).toList(),
      'subNavList': subNavList.map((item) => item.toJson()).toList(),
      'gridNav': gridNav.toJson(),
      'salesBox': salesBox.toJson(),
    };
  }
}