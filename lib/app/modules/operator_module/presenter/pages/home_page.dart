// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/home_page_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _loginStore = Modular.get<LoginStore>();

  @override
  void initState() {
    super.initState();
    _loginStore.getOperatorById(widget.operatorEntity.operatorId!,
        widget.operatorEntity.operatorOcupation!);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    return ValueListenableBuilder(
      valueListenable: _loginStore,
      builder: (_, operatorState, __) {
        if (operatorState is LoginLoadingState) {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
            child: Center(
              child: CircularProgressIndicator(
                color: indicatorColor,
              ),
            ),
          );
        }
        if (operatorState is LoginSuccessgState) {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
            child: Column(
              children: [
                HomePageComponent(
                  operator: operatorState.operatorEntity,
                  height: height * 0.25,
                  width: width,
                  color: seccondaryColor,
                ),
              ],
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(color: primaryColor),
          /* child: Column(
            children: [
              HomePageComponent(
                operator: !,
                height: height * 0.25,
                width: width,
                color: seccondaryColor,
              ),
            ],
          ), */
        );
      },
    );
  }
}

/* 

 */