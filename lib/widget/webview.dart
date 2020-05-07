import 'package:flutter/material.dart';

class Webview extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool backForbid;
  final bool hideAppBar;

  const Webview({Key key, this.url, this.statusBarColor, this.title, this.backForbid, this.hideAppBar}) : super(key: key);

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}