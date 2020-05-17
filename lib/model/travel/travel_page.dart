import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/http/api.dart';
import 'package:flutter_trip/model/travel/travel_model.dart';
import 'package:flutter_trip/model/travel/travel_tab_model.dart';
import 'package:flutter_trip/model/travel/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with SingleTickerProviderStateMixin{
  TabController _controller;
  List<TravelTab> tabs=[];
  TravelTabModel travelTabModel;

  @override
  void initState() async{
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    Response response = await Api.getTravelData();
    if(response.statusCode == 200) {
     _controller = TabController(length: response.data.tabs.length, vsync: this);
      setState(() {
        travelTabModel = TravelTabModel.fromJson(response.data);
        tabs = travelTabModel.tabs;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30),
          child: TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.black,
            labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Color(0xff2fcfbb),width: 3),
              insets: EdgeInsets.fromLTRB(0, 0, 0, 10)
            ),
            tabs: tabs.map((TravelTab tab) => Tab(text: tab.labelName,)).toList(),
          ),
        ),
        Flexible(child: TabBarView(controller: _controller, children: tabs.map((TravelTab tab)=>TravelTabPage(travelUrl: 'xxx', groupChannelCode: tab.groupChannelCode)).toList(),)),
        
      ],
    );
  }
}