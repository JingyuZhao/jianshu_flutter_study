import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

typedef void OnLoadMore(bool up);

class RefreshScaffold extends StatefulWidget {
  const RefreshScaffold(
      {Key key,
      this.labelId,
      this.isLoading,
      @required this.controller,
      this.enablePullUp: true,
      this.onRefresh,
      this.onLoadMore,
      this.child,
      this.itemCount,
      this.itemBuilder})
      : super(key: key);

  final String labelId;
  final bool isLoading;
  final RefreshController controller;
  final bool enablePullUp;
  final RefreshCallback onRefresh;
  final OnLoadMore onLoadMore;
  final Widget child;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  _RefreshScaffoldState createState() => _RefreshScaffoldState();
}

class _RefreshScaffoldState extends State<RefreshScaffold>
    with AutomaticKeepAliveClientMixin {
  bool isShowFloatBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.scrollController.addListener(() {
        int offset = widget.controller.scrollController.offset.toInt();
        if (offset < 480 && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else if (offset > 480 && !isShowFloatBtn) {
          isShowFloatBtn = true;
          setState(() {});
        }
      });
    });
  }

  /* 页面上拉到超过一定距离之后，显示回到顶部按钮 */
  Widget buildFloatingActionButton() {
    if (widget.controller.scrollController == null ||
        widget.controller.scrollController.offset.toInt() < 480) {
      return null;
    }

    return FloatingActionButton(
      heroTag: widget.labelId,
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.keyboard_arrow_up),
      onPressed: () {
        widget.controller.scrollController.animateTo(0.00,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: SmartRefresher(
              controller: widget.controller,
              enablePullDown: false,
              enablePullUp: widget.enablePullUp,
              enableOverScroll: false,
              onRefresh: widget.onLoadMore,
              child: widget.child ??
                  ListView.builder(
                    itemCount: widget.itemCount,
                    itemBuilder: widget.itemBuilder,
                  ),
            ),
          ),
          Offstage(
            offstage: widget.isLoading != true,
            child: Container(
              alignment: Alignment.center,
              color: Colours.gray_f0,
              child: ProgressView(),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
