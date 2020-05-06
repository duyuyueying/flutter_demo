import 'package:flutter_trip/model/grid_nav_item_model.dart';

// GridNavItem hotel	Object	NonNull
// GridNavItem flight	Object	NonNull
// GridNavItem travel	Object	NonNull

class GridNavModel{
  final GridNavItemModel hotel;
  final GridNavItemModel flight;
  final GridNavItemModel travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
      hotel: GridNavItemModel.fromJson(json['hotel']),
      flight: GridNavItemModel.fromJson(json['flight']),
      travel: GridNavItemModel.fromJson(json['travel']),
    );
  }
}