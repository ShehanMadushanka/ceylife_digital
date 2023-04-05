import 'dart:math' as math;

import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CeylifeExpandIcon extends StatefulWidget {
  const CeylifeExpandIcon({
    Key key,
    this.isExpanded = false,
    this.size = 24.0,
    @required this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
    this.color,
    this.disabledColor,
    this.expandedColor,
  })  : assert(isExpanded != null),
        assert(size != null),
        assert(padding != null),
        super(key: key);

  final bool isExpanded;
  final double size;
  final ValueChanged<bool> onPressed;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color disabledColor;
  final Color expandedColor;

  @override
  _CeylifeExpandIconState createState() => _CeylifeExpandIconState();
}

class _CeylifeExpandIconState extends State<CeylifeExpandIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween =
      Tween<double>(begin: 0.0, end: 0.5)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: kThemeAnimationDuration, vsync: this);
    _iconTurns = _controller.drive(_iconTurnTween);
    // If the widget is initially expanded, rotate the icon without animating it.
    if (widget.isExpanded) {
      _controller.value = math.pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CeylifeExpandIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void _handlePressed() {
    if (widget.onPressed != null) widget.onPressed(widget.isExpanded);
  }

  Color get _iconColor {
    if (widget.isExpanded && widget.expandedColor != null) {
      return widget.expandedColor;
    }

    if (widget.color != null) {
      return widget.color;
    }

    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.black54;
      case Brightness.dark:
        return Colors.white60;
    }

    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String onTapHint = widget.isExpanded
        ? localizations.expandedIconTapHint
        : localizations.collapsedIconTapHint;

    return Semantics(
      onTapHint: widget.onPressed == null ? null : onTapHint,
      child: IconButton(
        padding: widget.padding,
        iconSize: widget.size,
        color: _iconColor,
        disabledColor: widget.disabledColor,
        onPressed: widget.onPressed == null ? null : _handlePressed,
        icon: RotationTransition(
          turns: _iconTurns,
          child: const Icon(CeylifeIcons.ic_rounded_arrow_down),
        ),
      ),
    );
  }
}
