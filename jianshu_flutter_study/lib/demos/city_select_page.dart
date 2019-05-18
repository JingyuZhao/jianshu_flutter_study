import 'dart:convert';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:common_utils/common_utils.dart';


class CitySelectPage extends StatefulWidget {
  CitySelectPage(this.title,{Key key}) : super(key: key);
  final String title;

  _CitySelectPageState createState() => _CitySelectPageState();
}

class _CitySelectPageState extends State<CitySelectPage> {

  List<CityInfo> _cityList = List();
  List<CityInfo> _hotCityList = List();

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(15.0),
            height: 50.0,
            child: Text("当前城市: 成都市"),
          ),
          Expanded(
            flex: 1,
            child: AzListView(
              data: _cityList,
              topData: _hotCityList,
              isUseRealIndex: true,
              itemHeight: _itemHeight,
              itemBuilder: (context,model)=>_buildListItem(model),
              suspensionWidget:_buildSusWidget(_suspensionTag),
              suspensionHeight: _suspensionHeight,
              onSusTagChanged: (city){

              },
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildListItem(CityInfo model){
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: _buildSusWidget(model.getSuspensionTag()),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              LogUtil.e("OnItemClick: $model");
              Navigator.pop(context, model);
            },
          ),
        )
      ],
    );
  }

  //标题悬停
  Widget _buildSusWidget(String susTag){
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  //网络请求
  loadData() async{
    rootBundle.loadString("assets/data/china.json").then((value){
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((item){
        _cityList.add(CityInfo(name:item["name"]));
      });
      _handleList(_cityList);

      _hotCityList.add(CityInfo(name: "北京市", tagIndex: "热门"));
      _hotCityList.add(CityInfo(name: "广州市", tagIndex: "热门"));
      _hotCityList.add(CityInfo(name: "成都市", tagIndex: "热门"));
      _hotCityList.add(CityInfo(name: "深圳市", tagIndex: "热门"));
      _hotCityList.add(CityInfo(name: "杭州市", tagIndex: "热门"));
      _hotCityList.add(CityInfo(name: "武汉市", tagIndex: "热门"));

      setState(() {
        _suspensionTag = _hotCityList[0].tagIndex;
      });
    });
  }

  ///区分城市的拼音的第一个字母
  void _handleList(List<CityInfo> citys){
    if(citys == null || citys.isEmpty) return;
    for (var i = 0; i < citys.length; i++) {
      String pinyin = PinyinHelper.getPinyinE(citys[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      citys[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        citys[i].tagIndex = tag;
      } else {
        citys[i].tagIndex = "#";
      }
    }
    SuspensionUtil.sortListBySuspensionTag(citys);
  }
}

class CityInfo extends ISuspensionBean{
  String name;
  String tagIndex;
  String namePinyin;

  CityInfo({this.name,this.tagIndex,this.namePinyin});

  CityInfo.fromJson(Map<String,dynamic> json):name = json["name"],tagIndex = json["tagIndex"],namePinyin=json["namePinyin"];
  Map<String,dynamic> toJson() => {"name":this.name,"tahIndex":this.tagIndex,"namePinyin":this.namePinyin,"isShowSuspension":isShowSuspension};


  @override
  String getSuspensionTag() {
    return tagIndex;
  }
  @override
  String toString() {
    return "CityBean {" + " \"name\":\"" + name + "\"" + '}';
  }
}