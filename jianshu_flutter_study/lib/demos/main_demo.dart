import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/demos/demo_index.dart';
import 'package:jianshu_flutter_study/utils/navigator_util.dart';
import 'package:jianshu_flutter_study/utils/util_index.dart';

class ItemModel {
  String title;
  Widget page;

  ItemModel(this.title, this.page);
}

class MainDemoPage extends StatefulWidget {
  MainDemoPage({Key key}) : super(key: key);

  _MainDemoPageState createState() => _MainDemoPageState();
}

class _MainDemoPageState extends State<MainDemoPage> {
  List<ItemModel> mItemList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mItemList.add(new ItemModel("Github【common_utils】", null));
    mItemList.add(new ItemModel("汉字转拼音", new PinyinPage("汉字转拼音")));
    mItemList.add(new ItemModel("城市列表", new CitySelectPage("City Select")));
    mItemList.add(new ItemModel("Date Util", new DatePage("Date Util")));
    mItemList.add(new ItemModel("Regex Util", new RegexUtilPage("Regex Util")));
    mItemList.add(new ItemModel("Widget Util", new WidgetPage("Widget Util")));
    mItemList.add(new ItemModel("Timer Util", new TimerPage("Timer Util")));
    mItemList.add(new ItemModel("Money Util", new MoneyPage("Money Util")));
    mItemList
        .add(new ItemModel("Timeline Util", new TimelinePage("Timeline Util")));
    mItemList.add(new ItemModel("圆形/圆角头像", new RoundPortraitPage('圆形/圆角头像')));
    mItemList.add(new ItemModel("获取图片尺寸", new ImageSizePage('获取图片尺寸')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Demos"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            ItemModel model = mItemList[index];
            return _buildItem(model);
          },
        ),
      ),
    );
  }

  Widget _buildItem(ItemModel model) {
    return InkWell(
      onTap: () {
        if (model.page == null) {
          NavigatorUtil.pushWeb(context,
              url:
                  'https://github.com/Sky24n/common_utils/blob/master/README.md',
              title: 'Github【common_utils】');
        } else {
          NavigatorUtil.pushPages(context, model.page, pageName: model.title);
        }
      },
      child: Container(
          child: Text(
            model.title,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF666666),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              color: Colors.white,
              border: new Border.all(width: 0.33, color: Color(0XFFEFEFEF)))),
    );
  }
}
