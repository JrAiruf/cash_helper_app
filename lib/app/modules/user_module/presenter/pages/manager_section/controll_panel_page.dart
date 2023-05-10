// ignore_for_file: unused_local_variable

import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:flutter/material.dart';

class ControllPanelPage extends StatefulWidget {
  const ControllPanelPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ControllPanelPage> createState() => _ControllPanelPageState();
}

class _ControllPanelPageState extends State<ControllPanelPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: primaryColor,
        ),
      ),
    );
  }
}
