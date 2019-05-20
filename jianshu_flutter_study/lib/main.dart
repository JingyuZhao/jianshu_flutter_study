import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';
import 'package:jianshu_flutter_study/data/net/dio_util.dart';
import 'package:jianshu_flutter_study/ui/pages/main_page.dart';
import 'package:jianshu_flutter_study/ui/pages/page_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = Colours.app_main;
//网络设置相关
  void _init() {
    Options options = DioUtil.getDefOptions();
    options.baseUrl = Constant.SERVER_ADDRESS;
    HttpConfig config = HttpConfig(options: options);
    DioUtil().setConfig(config);
  }

  void _initAsync() async {
    await SpUtil.getInstance();
    if (!mounted) return;
    _loadLocale();
  }

  //本地化
  void _loadLocale() {
    setState(() {
      LanguageModel model = SpHelper.getLanguageModel();
      if (model != null) {
        _locale = Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }

      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null) {
        _themeColor = themeColorMap[_colorKey];
      }
    });
  }

  _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((onData) {
      _loadLocale();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLocalizedValues(localizedValues);
    _init();
    _initAsync();
    _initListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/MainPage": (context) => MainPage()},
      home: SplashPage(),
      theme: ThemeData.light().copyWith(
          primaryColor: _themeColor,
          accentColor: _themeColor,
          indicatorColor: Colors.white),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }
}
