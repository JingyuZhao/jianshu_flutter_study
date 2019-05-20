import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';
import 'package:jianshu_flutter_study/ui/pages/page_index.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of(context);
    ComModel github = ComModel(title: "Github", url: '', extra: "Get Start");
    ComModel author = ComModel(title: "作者", page: AuthorPage());
    ComModel other = ComModel(title: "其他", page: OtherPage());

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, Ids.titleAbout)),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 160,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Image.asset(
                    Utils.getImgPath('ic_launcher_news'),
                    width: 72,
                    fit: BoxFit.fill,
                    height: 72,
                  ),
                ),
                Gaps.vGap5,
                Text(
                  '版本号 ' + AppConfig.version,
                  style: new TextStyle(color: Colours.gray_99, fontSize: 14.0),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.33, color: Colours.divider)),
          ),
          ComArrowItem(github),
          ComArrowItem(author),
          StreamBuilder(
            stream: bloc.versionStream,
            builder: (context, snapshot) {
              VersionModel model = snapshot.data;
              return Container(
                child: Material(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      if (model == null) {
                        bloc.getVersion();
                      } else {
                        if (Utils.getUpdateStatus(model.version) != 0) {
                          NavigatorUtil.launchInBrowser(model.url,
                              title: model.title);
                        }
                      }
                    },
                    title: Text("版本更新"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          model == null
                              ? ''
                              : (Utils.getUpdateStatus(model.version) == 0
                                  ? '已是最新版'
                                  : '有新版本，去更新吧'),
                          style: TextStyle(
                              color: (model != null &&
                                      Utils.getUpdateStatus(model.version) != 0)
                                  ? Colors.red
                                  : Colors.grey,
                              fontSize: 14.0),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                decoration: Decorations.bottom,
              );
            },
          ),
          ComArrowItem(other)
        ],
      ),
    );
  }
}
