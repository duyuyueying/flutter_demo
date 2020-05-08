class TravelTabModel {
  final String url;
  final List<TravelTab> tabs;

  TravelTabModel({this.url, this.tabs});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) {
    var tabsJson = json['tabs'] as List;
    List<TravelTab> tabsList = tabsJson.map((item)=>TravelTab.fromJson(item)).toList();
    return TravelTabModel(
      url: json['url'],
      tabs: tabsList);
  }
}

class TravelTab{
  final String labelName;
  final String groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  factory TravelTab.fromJson(Map<String, dynamic> item) {
    return TravelTab(
      labelName: item['labelName'],
      groupChannelCode: item['groupChannelCode']
    );
  }
}