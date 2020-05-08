import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/http/api.dart';
import 'package:flutter_trip/model/search/search_model.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchUrl, this.keyword, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;

  @override
  void initState() {
    // _getSearchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('搜索')),
        body: Column(
      children: <Widget>[
        _appbar(),
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: searchModel?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int position) {
                      return _item(position);
                    })))
      ],
    ));
  }

  void _onTextChange(String value) {
    keyword = value;
    if (value.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    _getSearchList();
  }

  void _getSearchList() async {
    Map<String, dynamic> params = {"keyword": keyword};
    print(params);
    Response response = await Api.getSearch(params);
    if (response.statusCode == 200) {
      setState(() {
        searchModel = SearchModel.fromJson(response.data);
      });
      // SearchModel searchModel = SearchModel.fromJson(response.data);
      print(response.data);
    }
  }

  _appbar() {
    return Column(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defalutText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          )),
    ]);
  }

  Widget _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[position];
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(1),
            child: Image(
              height: 26,
              width: 26,
              image: AssetImage(_typeImage(item.type)),
            ),
          ),
          Column(
            children: <Widget>[
              _title(item),
              _subTitle(item),
            ],
          )
        ],
      ),
    );
  }

  String _typeImage(String type) {
    if (type == null) {
      return 'images/type_travelgroup.png';
    }
    return 'images/type_$type.png';
  }

  _title(SearchItem item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, keyword));
    spans.add(TextSpan(text: ' ${item.districtname??""} ${item.zonename??""}', style: TextStyle(fontSize: 14, color: Colors.grey)));

    return RichText(text: TextSpan(children: spans),);
  }

  _subTitle(SearchItem item) {
    return RichText(text: TextSpan(children: <TextSpan>[
      TextSpan(
        text: '${item.price??""}',
        style: TextStyle(fontSize: 16, color: Colors.orange)),
      TextSpan(
        text: '  ${item.star??""}',
        style: TextStyle(fontSize: 12, color: Colors.grey)),
    ]),);
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(
      fontSize: 16, color: Colors.orange
    );
    for(int i = 0; i < arr.length; i++ ){
      if((i+1)%2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if(val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
