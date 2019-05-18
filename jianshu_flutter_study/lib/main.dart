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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demos"),
        ),
        body: Center(
          child: RaisedButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
