import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

bool isReposInit = true;

class ReposPage extends StatelessWidget {
  const ReposPage({Key key, this.labelId}) : super(key: key);
  final String labelId;
  @override
  Widget build(BuildContext context) {
    LogUtil.e("ReposPage build...");

    RefreshController _controller = RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.homeEventStream.listen((data) {
      if (labelId == data.labelId) {
        _controller.sendBack(false, data.status);
      }
    });
    if (isReposInit) {
      isReposInit = false;
      Observable.just(1).delay(Duration(milliseconds: 500)).listen((onData) {
        bloc.onRefresh(labelId: labelId);
      });
    }
    return StreamBuilder(
      stream: bloc.recReposStream,
      builder: (context, snapshot) {
        return RefreshScaffold(
          labelId: labelId,
          isLoading: snapshot.data == null,
          controller: _controller,
          onRefresh: () {
            return bloc.onRefresh(labelId: labelId);
          },
          onLoadMore: (up) {
            return bloc.onLoadMore(labelId: labelId);
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (context, index) {
            return ReposItem(snapshot.data[index]);
          },
        );
      },
    );
  }
}
