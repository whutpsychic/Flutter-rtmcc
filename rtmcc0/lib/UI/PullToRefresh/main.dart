import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 默认的超时时长
const timeOut = 10000;

class PullToRefresh extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Function()? onRefresh;
  final Function()? onLoadMore;

  PullToRefresh(
      {this.key, required this.child, this.onRefresh, this.onLoadMore})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PullToRefreshState();
}

class PullToRefreshState extends State<PullToRefresh> {
  Future? rtk;
  Future? ltk;

  @override
  void initState() {
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    if (widget.onRefresh != null) widget.onRefresh!();

    rtk = Future.delayed(Duration(milliseconds: timeOut), () {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoadMore() async {
    if (widget.onLoadMore != null) widget.onLoadMore!();

    ltk = Future.delayed(Duration(milliseconds: timeOut), () {
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tStyle = TextStyle(fontSize: 15, color: Colors.grey[600]);

    return Container(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(
          complete: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 4),
                child: Icon(Icons.check, color: Colors.grey[500]),
              ),
              Text('加载完成', style: tStyle)
            ],
          ),
          failed: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 4),
                child: Icon(Icons.error, color: Colors.grey[500]),
              ),
              Text('加载失败', style: tStyle)
            ],
          ),
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            double height = 55.0;
            if (mode == LoadStatus.idle) {
              body = Text("");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败，请稍后重试");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("上拉加载更多");
            } else if (mode == LoadStatus.noMore) {
              body = Text("没有更多数据了");
            } else {
              body = Text("");
            }
            return Container(
              height: height,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoadMore,
        child: widget.child,
      ),
    );
  }

  refresh() {
    _onRefresh();
  }

  refreshComplete() {
    rtk = null;
    _refreshController.refreshCompleted();
  }

  refreshFailed() {
    rtk = null;
    _refreshController.refreshFailed();
  }

  loadMore() {
    _onLoadMore();
  }

  loadMoreComplete() {
    ltk = null;
    _refreshController.loadComplete();
  }

  loadMoreFailed() {
    ltk = null;
    _refreshController.loadFailed();
  }
}
