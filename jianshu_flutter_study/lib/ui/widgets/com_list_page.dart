import 'package:jianshu_flutter_study/common/component_index.dart';
import 'package:flutter/material.dart';

class ComListPage extends StatelessWidget {
  const ComListPage({Key key, this.labelId, this.cid}) : super(key: key);
  final String labelId;
  final int cid;

  @override
  Widget build(BuildContext context) {
    LogUtil.e('ComListPage build......');
    RefreshController controller = RefreshController();
    final ComListBloc bloc = BlocProvider.of<ComListBloc>(context);
    bloc.comListEventStream.listen((event) {
      if (cid == event.cid) {
        controller.sendBack(false, event.status);
      }
    });
    return StreamBuilder(
      stream: bloc.comListStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
        if (bloc.comList == null) {
          bloc.onRefresh(labelId: labelId, cid: cid);
        }

        return RefreshScaffold(
          labelId: labelId,
          isLoading: snapshot.data == null,
          controller: controller,
          onRefresh: () {
            return bloc.onRefresh(labelId: labelId, cid: cid);
          },
          onLoadMore: (up) {
            return bloc.onLoadMore(labelId: labelId, cid: cid);
          },
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return labelId == Ids.titleReposTree
                ? ReposItem(snapshot.data[index])
                : ArticleItem(snapshot.data[index]);
          },
        );
      },
    );
  }
}
