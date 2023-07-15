import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../components/widgets/manager_section_drawer.dart';
import '../../../controller/manager_controller.dart';

class AdminOptionsPage extends StatefulWidget {
  const AdminOptionsPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<AdminOptionsPage> createState() => _AdminOptionsPageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];

class _AdminOptionsPageState extends State<AdminOptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: ManagerSectionDrawer(
          currentPage: ManagerDrawerPage.adminOptions,
          managerEntity: widget.managerEntity,
          enterpriseId: _enterpriseId),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.purpleAccent,
        ),
      ),
    );
  }
}
