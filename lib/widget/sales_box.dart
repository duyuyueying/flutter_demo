import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key key, @required this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true));
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(salesBox.icon, height: 15, fit: BoxFit.fill),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(colors: [Color(0xfff4e63), Color(0xffff6cc9)], begin: Alignment.centerLeft, end: Alignment.centerRight)
                ),
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Webview(url: salesBox.moreUrl, title: '更多活动')));
                  },
                  child: Text('获取更多福利>', style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),)
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
        ),
        _doubleItem(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false),
        _doubleItem(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false),
        _doubleItem(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true)
      ],
    );
    // salesBox.forEach((model) {
    //   items.add(_item(context, model));
    // });
    // int separate = (salesBox.length/2+0.5).toInt();
    // return Column(
    //   children: <Widget>[
    //     Row(children: items.sublist(0, separate), mainAxisAlignment: MainAxisAlignment.spaceBetween, ),
    //     Padding(padding: EdgeInsets.only(top: 10), child: Row(children: items.sublist(separate, subNavList.length), mainAxisAlignment: MainAxisAlignment.spaceBetween, ),)
    //   ],
    // );
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool big, bool last) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _item(context, leftCard, big, last, true, false),
          _item(context, rightCard, big, last, false, true)
        ]);
  }

  Widget _item(BuildContext context, CommonModel model, bool big,  bool last, bool left, bool right) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: left? borderSide: BorderSide.none,
              bottom: last? borderSide: BorderSide.none,
              // left: right ? borderSide: BorderSide.none
            ),
          ),
          child: Image.network(
              model.icon,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width/2 - 10,
              height: big? 129:80,
            ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Webview(
                        url: model.url,
                        statusBarColor: model.statusBarColor,
                        hideAppBar: model.hideAppBar,
                      )));
        },
    );
  }
}
