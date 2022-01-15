import 'dart:ui';

import 'package:flutter/cupertino.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  Widget header;
  Widget? pre;
  double? max;
  double? min;

  StickyTabBarDelegate({required this.header, this.pre, this.max, this.min});

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        ((shrinkOffset - 5) / (this.minExtent - 5) * 255).clamp(0, 255).toInt();
    print(alpha);
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  double makeStickyHeaderAlpha(shrinkOffset) {
    final int alpha =
        ((shrinkOffset - 5) / (this.minExtent - 5) * 255).clamp(0, 255).toInt();
    return alpha / 255;
  }

  double makeStickyChildAlpha(shrinkOffset) {
    final int alpha =
        (shrinkOffset / this.minExtent * 255).clamp(0, 255).toInt();
    return 1 - (alpha / 255);
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          pre == null
              ? Container()
              : Opacity(
                  opacity: makeStickyChildAlpha(shrinkOffset), child: pre!),
          // 收起头部
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: min,
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: min,
                  child: Container(
                    child: Opacity(
                      opacity: makeStickyHeaderAlpha(shrinkOffset).toDouble(),
                      child: header,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => max == null ? 50 : max!;

  @override
  double get minExtent => min == null ? 50 : min!;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
