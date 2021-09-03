import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ActionSheet {
  final BuildContext context;
  ActionSheet(this.context);

  static of(context) {
    return ActionSheet(context);
  }

  void show({required List<String> items, required List<Function()> actions}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('请选择要进行的操作', style: TextStyle(fontSize: 16)),
        actions: items.map<CupertinoActionSheetAction>((el) {
          int i = items.indexWhere((element) => element == el);
          return CupertinoActionSheetAction(
            child: Text(el),
            onPressed: () {
              Navigator.pop(context);
              actions[i]();
            },
          );
        }).toList(),
        cancelButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: Text(
              '取消',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.blue,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
