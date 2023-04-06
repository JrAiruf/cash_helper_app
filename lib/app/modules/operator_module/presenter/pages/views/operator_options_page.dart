import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import "package:flutter/material.dart";

import '../../components/cash_helper_bottom_navigation_item.dart';

class OperatorOptionsPage extends StatefulWidget {
  const OperatorOptionsPage(
      {super.key,
      required this.operatorId,
      this.position,
      required this.pageController});
  final String operatorId;
  final BottomNavigationBarPosition? position;
  final PageController? pageController;
  @override
  State<OperatorOptionsPage> createState() => _OperatorOptionsPageState();
}

class _OperatorOptionsPageState extends State<OperatorOptionsPage> {
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
      child: Center(child:Text("Options"))
    );
  }
}
