import 'package:flutter_trip/model/common_model.dart';

// String startColor	String	NonNull
// String endColor	String	NonNull
// CommonModel mainItem	Object	NonNull
// CommonModel item1	Object	NonNull
// CommonModel item2	Object	NonNull
// CommonModel item3	Object	NonNull
// CommonModel item4	Object	NonNull

class GridNavItemModel{
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItemModel({this.startColor, this.endColor, this.mainItem, this.item1, this.item2, this.item3, this.item4});

  factory GridNavItemModel.fromJson(Map<String, dynamic> json) {
    return GridNavItemModel(
      endColor: json['endColor'],
      startColor: json['startColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']) ,
      item4: CommonModel.fromJson(json['item4']) ,
      ); 
  }
}