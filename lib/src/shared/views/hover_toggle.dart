import 'package:flutter/material.dart';

enum HoverMode { replace, overlay }

class HoverToggle extends StatefulWidget {
  const HoverToggle({
    super.key,
    required this.child,
    required this.hoverChild,
    required this.size,
    this.mode = HoverMode.replace,
  });

  final Widget child;
  final Widget hoverChild;
  final HoverMode mode;
  final Size size;

  @override
  State<HoverToggle> createState() => _HoverToggleState();
}

class _HoverToggleState extends State<HoverToggle> with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: MouseRegion(
        cursor: isHovered ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: (_) => setMaterialState(MaterialState.hovered, true),
        onExit: (_) => setMaterialState(MaterialState.hovered, false),
        child: widget.mode == HoverMode.replace
            ? _buildReplaceableChildren()
            : _buildChildrenStack(),
      ),
    );
  }

  Widget _buildChildrenStack() {
    Widget child = isHovered
        ? Opacity(
            opacity: .2,
            child: widget.child,
          )
        : widget.child;

    return Stack(
      children: <Widget>[
        child,
        if (isHovered) widget.hoverChild,
      ],
    );
  }

  Widget _buildReplaceableChildren() =>
      isHovered ? widget.hoverChild : widget.child;
}
