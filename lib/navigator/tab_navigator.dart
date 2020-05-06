import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavgator extends StatefulWidget {
  @override
  _TabNavgatorState createState() => _TabNavgatorState();
}

class _TabNavgatorState extends State<TabNavgator> {
  int _currIndex = 0;
  final PageController _controller = PageController(initialPage:1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currIndex,
        onTap: (index){
          setState(() {
            _controller.jumpToPage(index);
            this._currIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          activeIcon: Icon(Icons.home),
          title: Text('首页')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          activeIcon: Icon(Icons.search),
          title: Text('搜索')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          activeIcon: Icon(Icons.camera_alt),
          title: Text('旅拍')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          activeIcon: Icon(Icons.account_circle),
          title: Text('我的')
        ),
      ]),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      )
    );
  }
}