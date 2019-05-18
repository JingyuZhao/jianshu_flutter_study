import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';
class AuthorPage extends StatelessWidget {
  const AuthorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ComModel> list = new List();
    list.add(new ComModel(typeId: 0));
    list.add(new ComModel(
        title: "Github", url: "https://github.com/Sky24n", extra: "Go Follow"));
    list.add(new ComModel(
        title: "简书",
        url: "https://www.jianshu.com/u/cbf2ad25d33a",
        extra: "+关注"));
    list.add(new ComModel(
        title: "我的Flutter开源库集合",
        url: "https://www.jianshu.com/p/9e5cc4ba3a8e"));

    return Scaffold(
      appBar: AppBar(title: Text("作者"),centerTitle: true,),
      body: ListView.builder(itemBuilder: (context,index){
        ComModel model = list[index];
        if (model.typeId==0) {
          return Container(
            child:Material(color: Colors.white,child: ListTile(onTap: (){},title: Text("您的Star就是我的动力",style: TextStyle(color: Colors.red),textAlign: TextAlign.center,),),),
            decoration: Decorations.bottom,
          );
        }

        return ComArrowItem(model);
      },),
    );
  }
}