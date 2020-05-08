import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class Webview extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const Webview(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false})
      : super(key: key);

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
        body: Column(children: <Widget>[
      _appBar(Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
      Expanded(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (_isToMain(request.url)) {
              if (widget.backForbid) {
                return NavigationDecision.prevent;
              } else {
                Navigator.pop(context);
              }
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('page started loading:${url}');
          },
          onPageFinished: (String url) {
            print('page finished loading:${url}');
          },
        ),
      )
    ]));
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(color: backgroundColor, height: 30);
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              )),
              Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(widget.title ?? '',
                        style: TextStyle(color: backButtonColor, fontSize: 20)),
                  ))
            ],
          )),
    );
  }

  bool _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url.endsWith(value)) {
        contain = true;
        break;
      }
    }
    return contain;
  }
}
