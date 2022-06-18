import 'package:flutter/material.dart';
import './Button.dart';
import './LoadingIcon.dart';

class BlockButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;

  final Function? onLongPress;
  final Color? color;
  final bool? outlined;
  final bool? loading;
  final Widget? icon;

  BlockButton({
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.color,
    this.outlined,
    this.loading,
    this.icon,
  });

  static const double defaultIconSize = 20;

  static const double defaultIconMargin = 6;

  @override
  State<StatefulWidget> createState() => _BlockButtonState();
}

class _BlockButtonState extends State<BlockButton> {
  @override
  Widget build(BuildContext context) {
    bool _outlined = widget.outlined != null && widget.outlined!;
    bool _loading = widget.loading != null && widget.loading!;
    bool _hasIcon = widget.icon != null;
    return Container(
      height: 45,
      margin: EdgeInsets.only(bottom: 10),
      child: _outlined
          ? OutlinedButton(
              onPressed: _loading
                  ? null
                  : () {
                      widget.onPressed();
                    },
              onLongPress: _loading
                  ? null
                  : () {
                      widget.onLongPress!();
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _loading
                      ? ButtonIconContainer(child: LoadingIcon())
                      : Container(),
                  _hasIcon
                      ? ButtonIconContainer(child: widget.icon!)
                      : Container(),
                  widget.child
                ],
              ),
              style: Button.getOutlinedStyle(widget.color),
            )
          : ElevatedButton(
              onPressed: _loading
                  ? null
                  : () {
                      widget.onPressed();
                    },
              onLongPress: _loading
                  ? null
                  : () {
                      widget.onLongPress!();
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _loading
                      ? ButtonIconContainer(child: LoadingIcon())
                      : Container(),
                  _hasIcon
                      ? ButtonIconContainer(child: widget.icon!)
                      : Container(),
                  widget.child
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    Button.getFilledStyle(widget.color)),
                overlayColor: MaterialStateProperty.resolveWith(
                    Button.getFilledStyle(widget.color)),
              ),
            ),
    );
  }
}
