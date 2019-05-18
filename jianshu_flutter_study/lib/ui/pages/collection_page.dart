import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(IntlUtil.getString(context, Ids.titleCollection)),
        centerTitle: true,
      ),
      body: new ProgressView(),
    );
  }
}