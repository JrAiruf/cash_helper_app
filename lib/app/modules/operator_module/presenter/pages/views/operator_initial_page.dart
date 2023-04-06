import 'package:flutter/material.dart';

import '../../components/cash_helper_bottom_navigation_bar.dart';

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
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final _operatorPageController = PageController();
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Center(child: Text("Initial")));
  }
}
