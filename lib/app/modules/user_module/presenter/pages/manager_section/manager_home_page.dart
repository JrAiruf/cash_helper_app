import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../components/widgets/manager_section_drawer.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

final _loginStore = Modular.get<LoginStore>();
final _enterpriseId = Modular.args.params["enterpriseId"];

class _ManagerHomePageState extends State<ManagerHomePage> {
  @override
  void initState() {
    _loginStore.getUserById(_enterpriseId, widget.managerEntity.managerId!,
        widget.managerEntity.businessPosition!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    return ValueListenableBuilder(
      valueListenable: _loginStore,
      builder: (_, state, __) {
        if (state is LoginLoadingState) {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
            child: Center(
              child: CircularProgressIndicator(
                color: indicatorColor,
              ),
            ),
          );
        }
        if (state is ManagerLoginSuccessState) {
          final manager = state.managerEntity;
          return Scaffold(
            appBar: AppBar(),
            drawer: ManagerSectionDrawer(
              managerEntity: manager,
              enterpriseId: _enterpriseId,
              currentPage: ManagerDrawerPage.home,
              radius: 20,
              width: width * 0.75,
            ),
            body: Container(
              child: Center(child: Text(_enterpriseId)),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
          );
        }
      },
    );
  }
}
