import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/utils/utils.dart';

class RoundPortraitPage extends StatelessWidget {
  const RoundPortraitPage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      //  backgroundColor: Colors.grey,
      body: new Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new ClipOval(
              child: new Image.asset(Utils.getImgPath('ali_connors')),
            ),
            new CircleAvatar(
              radius: 36.0,
              backgroundImage: AssetImage(
                Utils.getImgPath('ali_connors'),
              ),
            ),
            new Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    Utils.getImgPath('ali_connors'),
                  ),
                ),
              ),
            ),
            new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.asset(Utils.getImgPath('ali_connors')),
            ),
            new Container(
              width: 88.0,
              height: 88.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6.0),
                image: DecorationImage(
                  image: AssetImage(
                    Utils.getImgPath('ali_connors'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
