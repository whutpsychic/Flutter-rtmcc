// 级联选择器视图
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './main.dart';

class LevelSelector extends StatefulWidget {
  final Key? key;
  final List<Map> data;
  final int depth;
  final Function? onChange;
  final Map? value;

  LevelSelector({
    this.key,
    required this.data,
    required this.depth,
    this.onChange,
    this.value,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LevelSelectorState();
}

class LevelSelectorState extends State<LevelSelector> {
  // 完整数据展开源组
  late List<Map> expandedData;
  // 完整数据源分组
  late List<List<Map>> dividedData;
  // 当前数据源分组
  late List<List<Map>> currentDataSource;
  // 当前值(位置)组
  late List<int> currI;

  @override
  void initState() {
    super.initState();
    _init(widget.depth);
  }

  _init(int dp) {
    List<List<Map>> _initcds = [];
    List<int> _cI = [];
    for (int i = 0; i < dp; i++) {
      _initcds.add([]);
      _cI.add(0);
    }
    // 设置当前数据源组
    setState(() {
      currentDataSource = _initcds;
      currI = _cI;
      expandedData = Selector.extendData(widget.data);
      dividedData = Selector.divideIt(expandedData, dp);
      currentDataSource[0] = dividedData[0];
      for (int i = 0; i < dp - 1; i++) {
        _findByParentId(i);
      }

      // =================设置默认值
      List<Map?> sv = Selector.lookBack(widget.value, dividedData);

      for (int hi = 0; hi < dp; hi++) {
        int w = currentDataSource[hi]
            .indexWhere((element) => element['value'] == sv[hi]?['value']);
        if (w != -1) {
          setState(() {
            currI[hi] = w;
          });
          if (hi < dp - 1) _findByParentId(hi);
        }
      }
    });
  }

  // 根据父源组找寻下层数据源组
  _findByParentId(int l, [int? i]) {
    int _i = i ?? currI[l];
    String pid;
    try {
      pid = currentDataSource[l][_i]['treeSelfIdentify'];
    } catch (e) {
      pid = "";
    }
    List<Map> _newl = dividedData[l + 1]
        .where((el) => el['treeParentIdentify'] == pid)
        .toList();
    setState(() {
      if (_newl.length == 0) {
        currentDataSource[l + 1] = [
          {"name": "无", "value": null}
        ];
      } else {
        currentDataSource[l + 1] = _newl;
      }
    });
  }

  getValueArr(int dp) {
    List<Map> result = [];

    for (int i = 0; i < dp; i++) {
      result.add(currentDataSource[i][currI[i]]);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: currentDataSource.map<Widget>(
        (e) {
          int _index = currentDataSource.indexWhere((el) => el == e);
          return Container(
            width: _screenWidth / widget.depth,
            child: CupertinoPicker(
              itemExtent: Selector.itemHeight,
              scrollController:
                  FixedExtentScrollController(initialItem: currI[_index]),
              onSelectedItemChanged: (i) {
                // ---------
                // 找到此item，并确认此item的parentId
                // 根据此parentId筛选下一列数据
                // 非最终列变动，才进行再渲染
                // 如果是共有三列并且第一列变动，则根据已变的第二列第一项进行第三列变动
                _lp(int x, [int? i]) {
                  if (x + 1 < widget.depth) {
                    _findByParentId(x, i);
                    _lp(x + 1);
                  }
                }

                setState(() {
                  currI[_index] = i;
                });

                _lp(_index, currI[_index]);
              },
              children: e
                  .map<Widget>((el) => Container(
                        alignment: Alignment.center,
                        height: Selector.itemHeight,
                        child: Text(
                          el['name'] ?? "",
                          style: TextStyle(fontSize: 18),
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ).toList(),
    );
  }
}
