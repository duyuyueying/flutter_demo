import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/http/api.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'dart:convert';

import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';

// import 'package:flutter_trip/model/home_model.dart';

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
  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          NotificationListener(
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
                        itemCount: _imgList.length,
                        autoplay: true,
                        itemBuilder: (context, index) {
                          return Image.network(
                            _imgList[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(),
                      )),
                      Padding(padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNav(localNavList: localNavList),),
                  Container(
                    child: ListTile(title: Text(resultString)),
                    height: 900,
                  )
                ],
              )),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              // color: Colors.red,
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(child: Padding(padding: EdgeInsets.only(top: 20), child: Text('首页'),),),
            ),
          )
        ],
      ),
    );
  }

  void _scroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if(alpha < 0) {
      alpha = 0;
    } else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha= alpha;
    });
  }

  void loadData() async{
    final Response response = await Api.getHomeData();
    if(response.statusCode == 200 ) {
      HomeModel model = HomeModel.fromJson(response.data);
      setState(() {
        localNavList = model.localNavList;
      });
      // var result = json.decode(response.body);
      // HomeModel
      // HomeModel.fromJson(response.data);
    }
    
  }
}

// Swiper(itemCount: _imgList.length,
//           autoplay: true,
//           itemBuilder: (context, index) {
//                   return Text('index:${index}');r
//                 }),
//         )q
