import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String showResult = '';
  // Future<CommonModel> fetchPost() async {
  //   final response = await http.get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
  //   final result = json.decode(response.body);
  //   return CommonModel.fromJson(result);

  // }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的')
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            child: Text('点我'),
            onTap: (){
             
            },
          ),
          Text(showResult),
          FutureBuilder<CommonModel> (
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('input a URL to start');
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if(snapshot.hasError) {
                    return new Text('${snapshot.error}');
                  } else {
                    return new Column(children: <Widget>[
                      Text('icon:${snapshot.data.icon}'),
                      Text('statusBarColor:${snapshot.data.statusBarColor}'),
                      Text('title:${snapshot.data.title}'),
                      Text('url:${snapshot.data.url}')
                    ]);
                  }
              }
          }
        )
        ],
      )
    );
  }
}

class CommonModel{
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}