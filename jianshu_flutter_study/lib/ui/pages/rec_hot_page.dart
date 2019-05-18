import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

class RecHotPage extends StatefulWidget {
  RecHotPage({Key key, this.title, this.titleId}) : super(key: key);

  final String title;
  final String titleId;
  _RecHotPageState createState() => _RecHotPageState();
}

class _RecHotPageState extends State<RecHotPage> {
  Widget _buildImg(String imgUrl) {
    if (ObjectUtil.isEmpty(imgUrl)) {
      return Container(
        width: 0.0,
      );
    }

    return Container(
      width: 72,
      height: 128,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10.0),
      child: CachedNetworkImage(
        width: 72,
        height: 128,
        fit: BoxFit.fill,
        imageUrl: imgUrl,
        placeholder: (context, url) => ProgressView(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    String labelId =
        widget.title ?? IntlUtil.getString(context, widget.titleId);

    bloc.homeEventStream.listen((data) {
      if (widget.titleId == data.labelId) {
        _controller.sendBack(false, data.status);
      }
    });

    Observable.just(1).delay(Duration(milliseconds: 500)).listen((onData) {
      bloc.getHotRecList(labelId);
    });

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text(
            widget.title ?? IntlUtil.getString(context, widget.titleId)),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: bloc.recListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ComModel>> snapshot) {
          return RefreshScaffold(
            labelId:
                widget.title ?? IntlUtil.getString(context, widget.titleId),
            isLoading: snapshot.data == null,
            controller: _controller,
            enablePullUp: false,
            onRefresh: () {
              return bloc.getHotRecList(labelId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              ComModel model = snapshot.data[index];
              return InkWell(
                onTap: () {
                  NavigatorUtil.pushWeb(context,
                      title: model.title, url: model.url, isHome: true);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              model.content == null ?? "",
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
                                  Utils.getTimeLine(
                                      context,
                                      DateUtil.getDateMsByTimeStr(
                                          model.updatedAt)),
                                  style: TextStyles.listExtra,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _buildImg(model.imgUrl)
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.33, color: Colours.divider),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
