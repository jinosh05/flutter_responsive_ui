import "package:flutter/material.dart";

import "../configs/space.dart";

class AppColumn extends StatelessWidget {
  const AppColumn({
    required this.children, super.key,
    this.padding,
    this.cstart = true,
    this.noScroll = false,
    this.controller,
  });

  final ScrollController? controller;
  final EdgeInsets? padding;
  final List<Widget> children;
  final bool cstart;
  final bool noScroll;

  @override
  Widget build(BuildContext context) {
    if (noScroll) {
      return Padding(
        padding: padding ?? Space.h!,
        child: Column(
          crossAxisAlignment:
              cstart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: children,
        ),
      );
    } else {
      return SingleChildScrollView(
        controller: controller ?? ScrollController(),
        padding: padding ?? Space.h,
        child: Column(
          crossAxisAlignment:
              cstart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: children,
        ),
      );
    }
  }
}
