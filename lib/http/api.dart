
import 'package:flutter_trip/http/http_manager.dart';

var http = HttpManager();

class Api {
  static Future getHomeData() async {
    return await http.get('http://www.devio.org/io/flutter_app/json/home_page.json');
  }
  static Future getSearch(Map<String, dynamic> params) async {
    return await http.get('https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=${params["keyword"]}');
  }
  // 旅拍模块类别接口
  static Future getTravelData() async {
    return await http.get('http://www.devio.org/io/flutter_app/json/travel_page.json');
  }
  static Future getTravelTab() async {
    return await http.post('https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5');
  }
}