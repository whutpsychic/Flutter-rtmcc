import 'package:flutter/material.dart';
import './config.dart';

class IconBtn extends StatelessWidget {
  final IconData? icon;
  final void Function()? onTap;
  final double? size;
  IconBtn(this.icon, {this.size, this.onTap});

  double _getSize() {
    if (size != null) return btnSize + size!;
    return btnSize;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(12),
          child: Icon(icon, size: _getSize(), color: styleColor),
        ),
        onTap: _onTap);
  }

  void _onTap() {
    if (onTap != null) onTap!();
  }
}
