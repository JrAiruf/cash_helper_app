import 'package:flutter/material.dart';

import '../../../components/cash_helper_bottom_navigation_bar.dart';

class OperatorInitialPage extends StatefulWidget {
  const OperatorInitialPage(
      {super.key,
      required this.operatorId,
      this.position,
      required this.pageController});
  final String operatorId;
  final BottomNavigationBarPosition? position;
  final PageController? pageController;
  @override
  State<OperatorInitialPage> createState() => _OperatorInitialtate();
}

class _OperatorInitialtate extends State<OperatorInitialPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(child: Text(widget.operatorId)));
  }
}
