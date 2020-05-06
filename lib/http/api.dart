
import 'package:flutter_trip/http/http_manager.dart';

var http = HttpManager();

class Api {
  static Future getHomeData() async {
    return await http.get('flutter_app/json/home_page.json');
  }
}