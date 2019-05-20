import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

bool isSystemInit = true;

class SystemPage extends StatelessWidget {
  const SystemPage({this.labelId, Key key}) : super(key: key);
  final String labelId;

  @override
  Widget build(BuildContext context) {
    LogUtil.e("SystemPage build......");
    RefreshController _controller = new RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);

    if (isSystemInit) {
      LogUtil.e("SystemPage init......");
      isSystemInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }
    return StreamBuilder(
        stream: bloc.treeStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
          return new RefreshScaffold(
            labelId: labelId,
            isLoading: snapshot.data == null,
            controller: _controller,
            enablePullUp: false,
            onRefresh: () {
              return bloc.onRefresh(labelId: labelId);
            },
            onLoadMore: (up) {},
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              TreeModel model = snapshot.data[index];
              return new TreeItem(model);
            },
          );
        });
  }
}
