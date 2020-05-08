import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/http/api.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'dart:convert';

import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

// import 'package:flutter_trip/model/home_model.dart';
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imgList = [
    'http://fpoimg.com/375x160',
    'http://fpoimg.com/375x160',
    'http://fpoimg.com/375x160'
  ];
  static const int APPBAR_SCROLL_OFFSET = 100;
  double appBarAlpha = 0;
  String resultString = '';
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: <Widget>[
              RefreshIndicator(
                  child: NotificationListener(
                      onNotification: (ScrollNotification notification) {
                        if (notification is ScrollUpdateNotification &&
                            notification.depth == 0) {
                          _scroll(notification.metrics.pixels);
                        }

                        return true;
                      },
                      child: ListView(
                        children: <Widget>[
                          Container(
                              height: 160,
                              color: Colors.red,
                              child: Swiper(
                                itemCount: bannerList.length,
                                autoplay: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          CommonModel model = bannerList[index];
                                          return Webview(
                                              url: model.url,
                                              title: model.title,
                                              hideAppBar: model.hideAppBar);
                                        }));
                                      },
                                      child: Image.network(
                                        bannerList[index].icon,
                                        fit: BoxFit.fill,
                                      ));
                                },
                                pagination: SwiperPagination(),
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                            child: LocalNav(localNavList: localNavList),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                            child: GridNav(gridNavModel: gridNavModel),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                            child: SubNav(subNavList: subNavList),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                            child: SalesBox(salesBox: salesBox),
                          ),
                        ],
                      )),
                  onRefresh: _handleRefresh),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0x66000000), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          height: 80.0,
                          decoration: BoxDecoration(color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
                          child: SearchBar(
                            searchBarType: appBarAlpha > .2
                                ? SearchBarType.homeLight
                                : SearchBarType.home,
                            inputBoxClick: _jumpToSearch,
                            speakClick: _jumpToSpeck,
                            defalutText: SEARCH_BAR_DEFAULT_TEXT,
                            leftButtonClick: () {},
                          ),
                        )
                      ),
                      
                    ],
                  ),
              
            ],
          ),
        ));
  }

  void _scroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<Null> _handleRefresh() async {
    final Response response = await Api.getHomeData();
    if (response.statusCode == 200) {
      HomeModel model = HomeModel.fromJson(response.data);
      setState(() {
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
      });
      _loading = false;
      // var result = json.decode(response.body);
      // HomeModel
      // HomeModel.fromJson(response.data);
    }
    return null;
  }

  void _jumpToSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT);
    }));
  }

  void _jumpToSpeck() {}
}

// Swiper(itemCount: _imgList.length,
//           autoplay: true,
//           itemBuilder: (context, index) {
//                   return Text('index:${index}');r
//                 }),
//         )q
