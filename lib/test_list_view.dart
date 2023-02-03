// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class TestListView extends StatefulWidget {
  const TestListView({super.key});

  @override
  State<TestListView> createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  final ScrollController scrollController = ScrollController();
  int itemCount = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent - 400) {}
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        // bounce();
        if (scrollNotification is ScrollEndNotification) {}

        if (scrollNotification.metrics.pixels >=
            scrollNotification.metrics.maxScrollExtent - 400) {}
        return true;
      },
      child: ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        cacheExtent: 10,
        physics: const CustomScrollPhysics(
          childWidth: 200,
        ),
        // physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemExtent: 200,
        itemCount: itemCount,
        itemBuilder: (context, index) => ListViewItem(),
      ),
    );
  }

  void bounce() {
    double itemSize = scrollController.position.maxScrollExtent / itemCount;

    int currentIndex = scrollController.offset ~/ itemSize;

    // check if the offset is more than the half of the current item size. if the offset is more than the half of the current item size, return true else,the next item is the target item.
    bool isMoreThanHalf = scrollController.offset % itemSize > itemSize / 2;

    // if the offset is more than the half of the current item size, scroll to the next item's offset else, scroll to the current item's offset.
    double target = isMoreThanHalf ? (currentIndex + 1) * itemSize : currentIndex * itemSize;

    // scroll to the taget offset.
    scrollController.animateTo(
      200,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
    );
  }
}

class ListViewItem extends StatelessWidget {
  ListViewItem({super.key});

  final Color _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 200,
        height: 200,
        child: DecoratedBox(
          decoration: BoxDecoration(color: _randomColor),
        ),
      ),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({
    this.childWidth,
    super.parent,
    this.shownChildCounts,
  });

  final double? childWidth;
  final int? shownChildCounts;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) => CustomScrollPhysics(
        childWidth: childWidth,
        shownChildCounts: shownChildCounts,
        parent: buildParent(ancestor),
      );

  double _getPage(ScrollMetrics position) =>
      position.pixels / (childWidth ?? position.viewportDimension);

  double _getPixels(ScrollMetrics position, double page) =>
      page * (childWidth ?? position.viewportDimension);

  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    var page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 3 / (shownChildCounts ?? 1);
    } else if (velocity > tolerance.velocity) {
      page += 3 / (shownChildCounts ?? 1);
    }

    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final Tolerance tolerance = this.tolerance;

    final target = _getTargetPixels(position, tolerance, velocity);

    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
