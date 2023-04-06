import 'package:flutter/material.dart';
import '../../../domain/entities/operator_entity.dart';
import '../../components/cash_helper_bottom_navigation_bar.dart';

class OperatorOppeningPage extends StatefulWidget {
  const OperatorOppeningPage(
      {super.key,
      required this.operatorEntity,
      required this.position,
      required this.pageController});

  final OperatorEntity operatorEntity;
  final BottomNavigationBarPosition position;
  final PageController pageController;

  @override
  State<StatefulWidget> createState() => _OperatorOppeningPageState();
}

class _OperatorOppeningPageState extends State<OperatorOppeningPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final _operatorPageController = PageController();
    return Container(
      child: Center(
        child: Text("Oppening"),
      ),
    );
  }
}
