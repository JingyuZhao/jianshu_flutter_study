import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';
import 'package:jianshu_flutter_study/ui/pages/language_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogUtil.e("SettingPage build......");
    final ApplicationBloc bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, Ids.titleSetting)),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.color_lens,
                  color: Colours.gray_66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    IntlUtil.getString(context, Ids.titleTheme),
                  ),
                )
              ],
            ),
            children: <Widget>[
              Wrap(
                children: themeColorMap.keys.map((String key) {
                  Color value = themeColorMap[key];
                  return InkWell(
                    onTap: () {
                      SpUtil.putString(Constant.KEY_THEME_COLOR, key);
                      bloc.sendAppEvent(Constant.TYPE_SYS_UPDATE);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 36,
                      height: 36,
                      color: value,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: Colours.gray_66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    IntlUtil.getString(context, Ids.titleLanguage),
                  ),
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    SpHelper.getLanguageModel() == null
                        ? IntlUtil.getString(context, Ids.languageAuto)
                        : IntlUtil.getString(
                            context, SpHelper.getLanguageModel().titleId,
                            languageCode: 'zh', countryCode: 'CH'),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colours.gray_99,
                    )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPages(context, LanguagePage(),
                  pageName: Ids.titleLanguage);
            },
          )
        ],
      ),
    );
  }
}
