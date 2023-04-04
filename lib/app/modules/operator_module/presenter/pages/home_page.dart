// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/home_page_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.operator});

  OperatorEntity operator;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _loginStore = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    return ValueListenableBuilder(
      valueListenable: _loginStore,
      builder: (_, currentOperator, __) {
        print(currentOperator?.operatorEmail);
        return Container(
          decoration: BoxDecoration(color: primaryColor),
          child: Column(
            children: [
              HomePageComponent(
                operator: currentOperator!,
                height: height * 0.25,
                width: width,
                color: seccondaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}

/* 

 */