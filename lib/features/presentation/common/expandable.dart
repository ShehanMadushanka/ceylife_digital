import 'package:ceylife_digital/features/presentation/common/expand_icon.dart';
import 'package:flutter/material.dart';

class ExpandableNotifier extends StatefulWidget {
  final ExpandableController controller;
  final bool initialExpanded;
  final Duration animationDuration;
  final Widget child;

  ExpandableNotifier(
      {Key key,
      this.controller,
      this.initialExpanded,
      this.animationDuration,
      @required this.child})
      : assert(!(controller != null && animationDuration != null)),
        assert(!(controller != null && initialExpanded != null)),
        super(key: key);

  @override
  _ExpandableNotifierState createState() => _ExpandableNotifierState();
}

class _ExpandableNotifierState extends State<ExpandableNotifier> {
  ExpandableController controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = ExpandableController(
          initialExpanded: widget.initialExpanded ?? false,
          animationDuration: widget.animationDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ExpandableInheritedNotifier(
        controller: controller ?? widget.controller, child: widget.child);
  }
}

class _ExpandableInheritedNotifier
    extends InheritedNotifier<ExpandableController> {
  _ExpandableInheritedNotifier(
      {@required ExpandableController controller, @required Widget child})
      : super(notifier: controller, child: child);
}

class ExpandableController extends ValueNotifier<bool> {
  bool get expanded => value;
  final Duration animationDuration;

  ExpandableController({bool initialExpanded, Duration animationDuration})
      : this.animationDuration =
            animationDuration ?? const Duration(milliseconds: 300),
        super(initialExpanded ?? false);

  set expanded(bool exp) {
    value = exp;
  }

  void toggle() {
    expanded = !expanded;
  }

  static ExpandableController of(BuildContext context,
      {bool rebuildOnChange = true}) {
    final notifier = rebuildOnChange
        ? context.inheritFromWidgetOfExactType(_ExpandableInheritedNotifier)
        : context.ancestorWidgetOfExactType(_ExpandableInheritedNotifier);
    return (notifier as _ExpandableInheritedNotifier)?.notifier;
  }
}

class Expandable extends StatelessWidget {
  final Widget collapsed;

  final Widget expanded;

  final ExpandableController controller;

  final Curve fadeCurve;
  final Curve sizeCurve;

  final double crossFadePoint;

  final AlignmentGeometry alignment;

  Expandable(
      {Key key,
      this.collapsed,
      this.expanded,
      this.controller,
      this.crossFadePoint = 0.5,
      this.fadeCurve = Curves.linear,
      this.sizeCurve = Curves.fastOutSlowIn,
      this.alignment = Alignment.topLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? ExpandableController.of(context);

    final double collapsedFadeStart =
        crossFadePoint < 0.5 ? 0 : (crossFadePoint * 2 - 1);

    final double collapsedFadeEnd =
        crossFadePoint < 0.5 ? 2 * crossFadePoint : 1;

    final double expandedFadeStart =
        crossFadePoint < 0.5 ? 0 : (crossFadePoint * 2 - 1);

    final double expandedFadeEnd =
        crossFadePoint < 0.5 ? 2 * crossFadePoint : 1;

    return AnimatedCrossFade(
      alignment: this.alignment,
      firstChild: collapsed ?? Container(),
      secondChild: expanded ?? Container(),
      firstCurve:
          Interval(collapsedFadeStart, collapsedFadeEnd, curve: fadeCurve),
      secondCurve:
          Interval(expandedFadeStart, expandedFadeEnd, curve: fadeCurve),
      sizeCurve: sizeCurve,
      crossFadeState: controller.expanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: controller.animationDuration,
    );
  }
}

typedef Widget ExpandableBuilder(
    BuildContext context, Widget collapsed, Widget expanded);

enum ExpandablePanelIconPlacement {
  left,
  right,
}

enum ExpandablePanelHeaderAlignment {
  top,
  center,
  bottom,
}

class ExpandablePanel extends StatelessWidget {
  final Widget header;

  final Widget collapsed;

  final Widget expanded;

  final bool tapHeaderToExpand;

  final bool tapBodyToCollapse;

  final bool hasIcon;

  final ExpandableBuilder builder;

  final ExpandablePanelIconPlacement iconPlacement;

  final Color iconColor;

  final ExpandablePanelHeaderAlignment headerAlignment;

  final ExpandableController controller;

  final bool isFromFAQ;

  static Widget defaultExpandableBuilder(
      BuildContext context, Widget collapsed, Widget expanded) {
    return Expandable(
      collapsed: collapsed,
      expanded: expanded,
      crossFadePoint: 0,
    );
  }

  ExpandablePanel({
    Key key,
    this.collapsed,
    this.header,
    this.expanded,
    this.tapHeaderToExpand = true,
    this.tapBodyToCollapse = false,
    this.hasIcon = true,
    this.iconPlacement = ExpandablePanelIconPlacement.right,
    this.iconColor,
    this.builder = defaultExpandableBuilder,
    this.headerAlignment = ExpandablePanelHeaderAlignment.top,
    this.controller,
    this.isFromFAQ = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildHeaderRow(Widget child) {
      if (!hasIcon) {
        return child;
      } else {
        final rowChildren = <Widget>[
          Expanded(
            child: child,
          ),
          ExpandableIcon(
            color: iconColor,
            isFromFAQ: isFromFAQ,
          ),
        ];
        return Row(
          crossAxisAlignment: calculateHeaderCrossAxisAlignment(),
          children: iconPlacement == ExpandablePanelIconPlacement.right
              ? rowChildren
              : rowChildren.reversed.toList(),
        );
      }
    }

    Widget buildHeader(Widget child) {
      return tapHeaderToExpand ? ExpandableButton(child: child) : child;
    }

    Widget buildBody(Widget child) {
      return tapBodyToCollapse ? ExpandableButton(child: child) : child;
    }

    Widget buildWithHeader() {
      return Column(
        children: <Widget>[
          buildHeaderRow(buildHeader(header)),
          builder(context, collapsed, buildBody(expanded))
        ],
      );
    }

    Widget buildWithoutHeader() {
      return buildHeaderRow(
          builder(context, buildHeader(collapsed), buildBody(expanded)));
    }

    final panel =
        this.header != null ? buildWithHeader() : buildWithoutHeader();

    if (controller != null) {
      return ExpandableNotifier(
        controller: controller,
        child: panel,
      );
    } else {
      final controller =
          ExpandableController.of(context, rebuildOnChange: false);
      if (controller == null) {
        return ExpandableNotifier(
          child: panel,
        );
      } else {
        return panel;
      }
    }
  }

  CrossAxisAlignment calculateHeaderCrossAxisAlignment() {
    switch (headerAlignment) {
      case ExpandablePanelHeaderAlignment.top:
        return CrossAxisAlignment.start;
      case ExpandablePanelHeaderAlignment.center:
        return CrossAxisAlignment.center;
      case ExpandablePanelHeaderAlignment.bottom:
        return CrossAxisAlignment.end;
    }
    assert(false);
    return null;
  }
}

class ExpandableIcon extends StatelessWidget {
  final Color color;
  final bool isFromFAQ;

  ExpandableIcon({this.color, this.isFromFAQ});

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);
    return Padding(
      padding: EdgeInsets.only(right: isFromFAQ ? 8.0 : 0.0),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: CeylifeExpandIcon(
          color: color,
          isExpanded: controller.expanded,
          onPressed: (exp) {
            controller.toggle();
          },
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}

class ExpandableButton extends StatelessWidget {
  final Widget child;

  ExpandableButton({this.child});

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);
    return InkWell(
        onTap: () {
          controller.toggle();
        },
        child: child);
  }
}

class ScrollOnExpand extends StatefulWidget {
  final Widget child;
  final Duration scrollAnimationDuration;

  final bool scrollOnExpand;

  final bool scrollOnCollapse;

  ScrollOnExpand({
    Key key,
    @required this.child,
    this.scrollAnimationDuration = const Duration(milliseconds: 300),
    this.scrollOnExpand = true,
    this.scrollOnCollapse = true,
  }) : super(key: key);

  @override
  _ScrollOnExpandState createState() => _ScrollOnExpandState();
}

class _ScrollOnExpandState extends State<ScrollOnExpand> {
  ExpandableController _controller;
  int _isAnimating = 0;
  BuildContext _lastContext;

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController.of(context, rebuildOnChange: false);
    _controller.addListener(_expandedStateChanged);
  }

  @override
  void didUpdateWidget(ScrollOnExpand oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newController =
        ExpandableController.of(context, rebuildOnChange: false);
    if (newController != _controller) {
      _controller.removeListener(_expandedStateChanged);
      _controller = newController;
      _controller.addListener(_expandedStateChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_expandedStateChanged);
  }

  _animationComplete() {
    _isAnimating--;
    if (_isAnimating == 0 && _lastContext != null && mounted) {
      if ((_controller.expanded && widget.scrollOnExpand) ||
          (!_controller.expanded && widget.scrollOnCollapse)) {
        _lastContext
            ?.findRenderObject()
            ?.showOnScreen(duration: widget.scrollAnimationDuration);
      }
    }
  }

  _expandedStateChanged() {
    _isAnimating++;
    Future.delayed(_controller.animationDuration + Duration(milliseconds: 10),
        _animationComplete);
  }

  @override
  Widget build(BuildContext context) {
    _lastContext = context;
    return widget.child;
  }
}
