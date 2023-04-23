import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

class RemoveOperatorAccountPage extends StatefulWidget {
  const RemoveOperatorAccountPage({super.key, required this.operatorEntity});

  final OperatorEntity operatorEntity;

  @override
  State<RemoveOperatorAccountPage> createState() =>
      _RemoveOperatorAccountPageState();
}

class _RemoveOperatorAccountPageState extends State<RemoveOperatorAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
