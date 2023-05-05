import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

final _loginStore = Modular.get<LoginStore>();
final enterpriseId = Modular.args.params["enterpriseId"];

class _ManagerHomePageState extends State<ManagerHomePage> {
  @override
  void initState() {
    _loginStore.getOperatorById(widget.managerEntity.managerId!, enterpriseId,
        widget.managerEntity.businessPosition!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text(enterpriseId)),
      ),
    );
  }
}
