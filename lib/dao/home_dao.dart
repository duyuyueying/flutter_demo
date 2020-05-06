import 'dart:convert';

import 'package:flutter_trip/http/api.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:dio/dio.dart';

const Home_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';
class HomeDao{
  static Future<HomeModel> fetch() async {
    final response = await Api.getHomeData();
    if(response.statusCode == 200 ) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }
  }
}