import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/models/models.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

class ComArrowItem extends StatelessWidget {
  
  const ComArrowItem(this.model,{Key key}) : super(key: key);
  final ComModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(color: Colors.white,child: ListTile(onTap: (){},title: Text(model.title == null ? "" : model.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
                model.extra == null ? "" : model.extra,
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              new Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
        ],
      ),),),
      decoration: Decorations.bottom,
    );
  }
}