import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/http/api.dart';
import 'package:flutter_trip/model/travel/travel_model.dart';
import 'package:flutter_trip/model/travel/travel_tab_model.dart';

const PAGE_SIZE = 20;
class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  const TravelTabPage({Key key, this.travelUrl, this.groupChannelCode}) : super(key: key);
  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>{
  List<TravelItem> travleItems;
  int pageIndex = 1;

  @override
  void initState() async{
    // TODO: implement initState
    super.initState();
    _loadData();
      }
    
      @override
      void dispose() {
        // TODO: implement dispose
        super.dispose();
      }
    
      @override
      Widget build(BuildContext context) {
        return StaggeredGridView.countBuilder(crossAxisCount: 4, itemCount: travleItems?.length ?? 0, itemBuilder: (BuildContext context, int index) => _TravelItem(index: index, item: travleItems[index]), staggeredTileBuilder: (int index)=> StaggeredTile.fit(2));
              }
            
              void _loadData() {}
        }
        
        class _TravelItem extends StatelessWidget{
          final TravelItem item;
          final int index;

  const _TravelItem({Key key, this.item, this.index}) : super(key: key);
          @override
  Widget build(BuildContext context) {
    return Container(
      child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: [
            _itemImage()
                      ],
                    ),
                  )
                );
              }
            
              _itemImage() {
                return Stack(children: [
                  Image.network(item.aritical.images[0].dynamicUrl),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1,),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      child: Row(children: [
                          Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.location_on, color: Colors.white, size: 12,),),
                          LimitedBox(maxWidth: 130, child: Text(_poiName()))
                                                  ],)
                                              ) 
                                              )
                                          ],)
                                        }
                          
                            String _poiName() {
                              return item.aritical.pois == null || item.aritical.pois.length == 0 ? '未知' :item.aritical.pois[0]?.poiName ?? '未知';

                            }
}