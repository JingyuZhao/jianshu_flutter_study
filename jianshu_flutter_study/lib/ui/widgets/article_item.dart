import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(this.model, {Key key, this.isHome}) : super(key: key);

  final ReposModel model;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.pushWeb(context,
            title: model.title, url: model.link, isHome: isHome);
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.listTitle,
                  ),
                  Gaps.vGap10,
                  Text(
                    model.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.listContent,
                  ),
                  Gaps.vGap5,
                  Row(
                    children: <Widget>[
                      Text(
                        model.author,
                        style: TextStyles.listExtra,
                      ),
                      Gaps.hGap10,
                      Text(
                        Utils.getTimeLine(context, model.publishTime),
                        style: TextStyles.listExtra,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 12.0),
              child: CircleAvatar(
                radius: 28.0,
                backgroundColor: Utils.getCircleBg(model.superChapterName),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    model.superChapterName,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.33, color: Colours.divider)),
      ),
    );
  }
}
