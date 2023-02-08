import 'package:flutter/cupertino.dart';

class Button extends StatefulWidget {
  final Widget child;
  final void Function()? onPressed;
  final Future<void> Function()? onAsyncPressed;
  final double? minSize;
  final bool hasPressedOpacity;
  const Button({
    required this.child,
    this.onPressed,
    this.onAsyncPressed,
    this.minSize = 20,
    this.hasPressedOpacity = true,
    super.key,
  }) : assert(onPressed == null || onAsyncPressed == null);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isRequesting = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: widget.minSize,
      borderRadius: BorderRadius.zero,
      pressedOpacity: widget.hasPressedOpacity ? 0.4 : 1,
      onPressed: () async {
        if (widget.onAsyncPressed != null) {
          if (isRequesting) return;
          isRequesting = true;
          try {
            await widget.onAsyncPressed!();
          } catch (_) {}
          isRequesting = false;
        }
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: widget.child,
    );
  }
}
