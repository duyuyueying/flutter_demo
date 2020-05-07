import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/http/api.dart';
import 'package:flutter_trip/model/travel/travel_model.dart';
import 'package:flutter_trip/model/travel/travel_tab_model.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  void initState() {
    // TODO: implement initState
    _getTravelTabData();
    _getTravelListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('旅拍')));
  }

  void _getTravelTabData() async{
    Response response = await Api.getTravelTab();
    if(response.statusCode == 200) {
      TravelTabModel travelTab = TravelTabModel.fromJson(response.data);
    }
  }

  void _getTravelListData() async{
    var params = {
      "districtId": -1,
      "groupChannelCode": "RX-OMF",
      "type": null,
      "lat": -180,
      "lon": -180,
      "locatedDistrictId": 0,
      // "pagePara": {
      //   "pageIndex": 1,
      //   "pageSize": 10,
      //   "sortType": 9,
      //   "sortDirection": 0
      // },
      "imageCutType": 1,
      // "head": {'cid': "09031014111431397988"},
      "contentType": "json"
    };
    Response response = await Api.getTravelData(params);
    if(response.statusCode == 200) {
      TravelModel travelModel = TravelModel.fromJson(response.data);
    }
  }
}
