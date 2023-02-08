import 'package:flutter/material.dart';

class DCAnimateWidget extends StatefulWidget {
  final int index;
  final Widget child;
  final double beginX;
  final double endX;
  final int delay;

  const DCAnimateWidget({
    required this.index,
    required this.child,
    required this.beginX,
    this.delay = 80,
    this.endX = 0,
    super.key,
  });

  factory DCAnimateWidget.listItem({
    required int index,
    required Widget child,
  }) {
    return DCAnimateWidget(
      index: index,
      beginX: -100.0,
      child: child,
    );
  }

  factory DCAnimateWidget.tagItem({
    required int index,
    required Widget child,
  }) {
    return DCAnimateWidget(
      index: index,
      beginX: 50.0,
      delay: 250,
      child: child,
    );
  }

  @override
  State<DCAnimateWidget> createState() => _DCAnimateWidgetState();
}

class _DCAnimateWidgetState extends State<DCAnimateWidget>
    with TickerProviderStateMixin {
  late AnimationController offsetController;
  late Animation offsetX;
  late Animation opacity;
  @override
  void initState() {
    super.initState();
    offsetController = AnimationController(
        duration: Duration(milliseconds: widget.delay + 270), vsync: this);
    offsetX = Tween<double>(begin: widget.beginX, end: widget.endX).animate(
        CurvedAnimation(parent: offsetController, curve: Curves.easeInOut));
    opacity = Tween<double>(begin: 0, end: 1).animate(offsetController);
    Future.delayed(Duration(milliseconds: widget.delay * (widget.index + 1)),
        () {
      offsetController.forward();
    });
  }

  @override
  void dispose() {
    offsetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: offsetController,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.translate(
            offset: Offset(offsetX.value, 0),
            child: child,
          ),
        );
      },
    );
  }
}
