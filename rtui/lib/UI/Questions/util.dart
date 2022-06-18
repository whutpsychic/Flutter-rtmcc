import 'package:flutter/material.dart';

// 所有选项的前缀 A-H (每题最多8个选项)
const List<String> serilizedPrefix = ["A", "B", "C", "D", "E", "F", "G", "H"];

class SelectItem extends StatelessWidget {
  final String text;
  final int value;
  final bool? active;
  final Function(int v)? onTap;
  final Size? size;
  final Widget? child;
  SelectItem({
    required this.text,
    required this.value,
    this.active,
    this.onTap,
    this.size,
    this.child,
  });

  @override
  build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    List<Color> colorStyle = _renderColorStyle();
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!(value);
      },
      child: Container(
        width: size != null ? size!.width : _screenWidth,
        height: size != null ? size!.height : null,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: colorStyle[0],
          border: Border.all(width: 1, color: colorStyle[1]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child != null ? child : Text(text),
      ),
    );
  }

  _renderColorStyle() {
    bool _active = active != null && active!;
    if (_active)
      return [Colors.yellow[300]!, Colors.yellow[800]!];
    else {
      return [Colors.blue[50]!, Colors.blue[300]!];
    }
  }
}

// 根据类型返回题型名称
String getQuestionTypeName(dynamic x) {
  switch (x) {
    case 1:
    case "1":
      return "单选题";
    case 2:
    case "2":
      return "多选题";
    case 3:
    case "3":
      return "选择填空";
    case 4:
    case "4":
      return "填空题";
    case 5:
    case "5":
      return "判断题";
    case 6:
    case "6":
      return "简答题";
    case 7:
    case "7":
      return "排序题";
    default:
      return "未知题型";
  }
}

// 判断一个数组里是否有那个项（多选题去重用）
bool hasIt(List arr, dynamic it) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == it) return true;
  }
  return false;
}
