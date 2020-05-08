import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('搜索')),
        body: Column(
      children: <Widget>[
        SearchBar(
          hideLeft: true,
          defalutText: 'haha',
          hint: '123',
          leftButtonClick: () {
            Navigator.pop(context);
          },
          onChanged: _onTextChange,
        )
      ],
    ));
  }

  void _onTextChange(String value) {}
}
