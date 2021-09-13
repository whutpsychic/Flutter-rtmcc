import 'package:flutter/material.dart';
import '../../core/MyPage/main.dart';
import '../../UI/PullToRefresh/main.dart';

GlobalKey<PullToRefreshState> pk = GlobalKey();

class PullToRefreshPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<PullToRefreshPage> with MyPage {
  @override
  void initState() {
    super.initState();
  }

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      items = ["1", "2", "3", "4", "5", "6", "7", "8"];
    });
    pk.currentState?.refreshComplete();
  }

  void _onLoadMore() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      items = [...items, "980"];
    });
    pk.currentState?.loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "下拉刷新",
      child: Container(
        child: PullToRefresh(
          key: pk,
          child: ListView.builder(
            itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
            itemExtent: 120.0,
            itemCount: items.length,
          ),
          onRefresh: _onRefresh,
          onLoadMore: _onLoadMore,
        ),
      ),
    );
  }
}
