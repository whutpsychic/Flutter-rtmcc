// 树形数据选择器视图
// 默认打开第一个跟节点
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './main.dart';

// 元数据模板
class TreeNodeData {
  final String? id;
  final String name;
  final dynamic value;
  final Map dataSource;
  TreeNodeData({
    this.id,
    required this.name,
    required this.value,
    required this.dataSource,
  });
}

// 主入口
class TreeSelector extends StatefulWidget {
  final Key? key;
  final List<Map> data;
  final Function? onChange;
  final dynamic value;

  TreeSelector({
    this.key,
    required this.data,
    this.onChange,
    this.value,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TreeSelectorState();
}

class TreeSelectorState extends State<TreeSelector> {
  TreeNodeData? currentEl;

  @override
  void initState() {
    super.initState();

    // 默认值
    if (widget.value != null) {
      // 找到并设置当前值
      List _ed = Selector.extendData(widget.data);
      var x =
          _ed.where((element) => element['value'] == widget.value).toList()[0];

      setState(() {
        currentEl =
            TreeNodeData(name: x['name'], value: x['value'], dataSource: {});
      });
    }
    // 默认展开第一个根节点
    else {}
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: _screenWidth,
        padding: EdgeInsets.all(10),
        child: Column(
          children: _generateTreeNodeList(children: widget.data, outside: true),
        ),
      ),
    );
  }

  onSelected(data) {
    setState(() {
      currentEl = data;
    });
  }

  _generateTreeNode(dataSource, [bool? expanded]) {
    return TreeNode(
      anchor: currentEl,
      onSelected: onSelected,
      expanded: expanded,
      data: TreeNodeData(
        name: dataSource['name'],
        value: dataSource['value'],
        dataSource: dataSource,
      ),
      children: _generateTreeNodeList(children: dataSource['children'] ?? []),
    );
  }

  _generateTreeNodeList({required List<Map> children, bool? outside}) {
    return children.map<TreeNode>((e) {
      bool elhell = (e == children.first && outside != null && outside);
      return _generateTreeNode(e, elhell);
    }).toList();
  }

  getValue() {
    return currentEl;
  }
}

// 可迭代的树形元数据
class TreeNode extends StatefulWidget {
  final TreeNodeData data;
  final List<TreeNode>? children;
  final Function? onSelected;
  final bool? expanded;
  final TreeNodeData? anchor;
  TreeNode({
    required this.data,
    this.children,
    this.expanded,
    this.anchor,
    this.onSelected,
  });

  @override
  State<StatefulWidget> createState() => TreeNodeState();
}

class TreeNodeState extends State<TreeNode> {
  // 默认不展开
  bool _exp = false;

  // 默认未选中
  bool _selected = false;

  int nums = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      // 是否展开
      _exp = _loopSearchfor(widget.children, widget.anchor) ||
              widget.expanded != null && widget.expanded!
          ? true
          : false;

      // 是否选中
      _selected = (widget.anchor?.value == widget.data.value);
    });
  }

  // 寻找锚点并展开此点根
  bool _loopSearchfor(List<TreeNode>? children, TreeNodeData? ce) {
    bool result = false;
    if (children != null && children.length > 0) {
      for (int i = 0; i < children.length; i++) {
        nums++;
        // 如果本child已匹配成功
        if (children[i].data.value == ce?.value) {
          return true;
        }
        // 如果本child匹配不成功
        else {
          // 确认下层存在并返回下层寻找结果
          if (children[i].children != null &&
              children[i].children!.length > 0) {
            result = _loopSearchfor(children[i].children, ce);
            if (result) return true;
          }
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // 是否选中
    _selected = widget.anchor?.value == widget.data.value;

    return Container(
      child: Column(
        children: [
          TreeNodeUnit(
            data: widget.data,
            selected: _selected,
            expanded: _exp,
            noKids: widget.children == null || widget.children!.length == 0,
            onExpand: () {
              setState(() {
                _exp = !_exp;
              });
            },
            onSelect: () {
              if (widget.onSelected != null) widget.onSelected!(widget.data);
            },
          ),
          _exp
              ? Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    children: widget.children!.map<Widget>((e) {
                      return TreeNode(
                        data: e.data,
                        children: e.children,
                        onSelected: e.onSelected,
                        anchor: widget.anchor,
                      );
                    }).toList(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class TreeNodeUnit extends StatefulWidget {
  final TreeNodeData data;
  final bool selected;
  final bool expanded;
  final bool noKids;
  final Function()? onExpand;
  final Function()? onSelect;
  TreeNodeUnit({
    required this.data,
    required this.selected,
    required this.expanded,
    required this.noKids,
    this.onExpand,
    this.onSelect,
  });

  @override
  State<StatefulWidget> createState() => TreeNodeUnitState();
}

class TreeNodeUnitState extends State<TreeNodeUnit> {
  @override
  Widget build(BuildContext context) {
    bool _selected = widget.selected ? true : false;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        child: Row(
          children: [
            widget.noKids
                ? Container(width: 24, height: 20)
                : GestureDetector(
                    onTap: widget.onExpand,
                    child: widget.expanded
                        ? Icon(Icons.arrow_drop_down)
                        : Icon(Icons.arrow_right),
                  ),
            GestureDetector(
              onTap: widget.onSelect,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                color: _selected ? Colors.blue : null,
                child: Text(
                  widget.data.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: _selected ? Colors.white : Colors.black,
                    decoration: TextDecoration.none,
                    letterSpacing: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
