// 针对 ListView 进行的再封装 - RTListView
// ========================================
// 开发者：zbc
// 创建日期：                      2021-04-27
// 上次修改日期：                   2021-07-12
// ========================================
import 'package:flutter/material.dart';

class RTListView extends StatefulWidget {
  // ===================== constructor =====================
  // 内容列表
  final List<Widget>? children;
  // 下拉刷新回调
  final Future<void> Function() onRefresh;
  // 滚动至底部回调（加载更多）
  final Function? onEndReach;
  RTListView(
      {Key? key, this.children, required this.onRefresh, this.onEndReach})
      : super(key: key);
  // ===================== constructor =====================

  @override
  State<StatefulWidget> createState() => RTListViewState();
}

class RTListViewState extends State<RTListView> {
  GlobalKey<RefreshIndicatorState> _key = GlobalKey();

  ScrollController listScrollController = ScrollController();

  // 防止停留底部反复触发endReach
  bool _allowEndReach = true;

  @override
  void initState() {
    super.initState();

    // 触发拉到底函数
    Future.delayed(Duration(milliseconds: 10), () {
      listScrollController.addListener(() {
        // 当还差30到底的时候
        if (listScrollController.position.pixels >=
            listScrollController.position.maxScrollExtent - 30) {
          // 拉到底的时候
          if (widget.onEndReach is Function && _allowEndReach)
            widget.onEndReach!();
          setState(() {
            _allowEndReach = false;
          });
        } else {
          setState(() {
            _allowEndReach = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: widget.onRefresh,
      child: ListView(
        controller: listScrollController,
        children: widget.children ?? [],
      ),
    );
  }

  load() {
    _key.currentState?.show();
  }
}
