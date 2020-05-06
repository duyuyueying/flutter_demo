// ConfigModel config	Object	NonNull
// List<CommonModel> bannerList	Array	NonNull
// List<CommonModel> localNavList	Array	NonNull
// GridNavModel gridNav	Object	NonNull
// List<CommonModel> subNavList	Array	NonNull
// SalesBoxModel salesBox	Object	NonNull

import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel{
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel({this.config, this.bannerList, this.localNavList, this.gridNav, this.subNavList, this.salesBox});


  factory HomeModel.fromJson(Map<String, dynamic> json) {
    // 将数组转为List
    var localNavListJson = json['localNavList'] as List;
    // 循环遍历将所有的子item都转换为commonMedel类
     List<CommonModel> localNavList = localNavListJson.map((i)=>CommonModel.fromJson(i)).toList();

     // 将数组转为List
    var bannerListJson = json['bannerList'] as List;
    // 循环遍历将所有的子item都转换为commonMedel类
     List<CommonModel> bannerList = bannerListJson.map((i)=>CommonModel.fromJson(i)).toList();

    // 将数组转为List
    var subNavListJson = json['subNavList'] as List;
    // 循环遍历将所有的子item都转换为commonMedel类
     List<CommonModel> subNavList = subNavListJson.map((i)=>CommonModel.fromJson(i)).toList();
    
    return HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox'])
    );
    
  } 
}