import 'package:flutter/material.dart';
import './LoadingIcon.dart';

class Button extends StatefulWidget {
  final Widget child;
  final Function onPressed;
  final Size size;

  final Function? onLongPress;
  final Color? color;
  final bool? filled;
  final bool? loading;
  final Widget? icon;

  Button({
    required this.child,
    required this.onPressed,
    required this.size,
    this.onLongPress,
    this.color,
    this.filled,
    this.loading,
    this.icon,
  });

  static const double defaultIconSize = 20;
  static const double defaultIconMargin = 6;

  static final Function getFilledStyle = _getFilledStyle;
  static final Function getOutlinedStyle = _getOutlinedStyle;
  static final Function darken = _darken;

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    bool _filled = widget.filled != null && widget.filled!;
    bool _loading = widget.loading != null && widget.loading!;
    bool _hasIcon = widget.icon != null;
    return Container(
      width: widget.size.width +
          (_loading ? Button.defaultIconSize + Button.defaultIconMargin : 0),
      height: widget.size.height,
      child: _filled
          ? ElevatedButton(
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
                    _getFilledStyle(widget.color)),
                overlayColor: MaterialStateProperty.resolveWith(
                    _getFilledStyle(widget.color)),
              ),
            )
          : OutlinedButton(
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
              style: _getOutlinedStyle(widget.color),
            ),
    );
  }
}

_getFilledStyle(Color? color) {
  Color _color = color ?? Colors.blue;
  return (Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.pressed,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return _darken(_color, 0.12);
    }
    return color;
  };
}

_getOutlinedStyle(Color? color) {
  Color _color = color ?? Colors.blue;
  return OutlinedButton.styleFrom(
    side: BorderSide(
      width: 1.0,
      color: _color,
    ),
    primary: _color,
  );
}

Color _darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

class ButtonIconContainer extends StatelessWidget {
  final Widget child;
  ButtonIconContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Button.defaultIconMargin),
      child: child,
    );
  }
}
