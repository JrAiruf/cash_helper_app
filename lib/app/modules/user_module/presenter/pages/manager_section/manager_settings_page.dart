import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/manager_entity.dart';
import '../../components/widgets/manager_section_drawer.dart';
import '../../controller/manager_controller.dart';

class ManagerSettingsPage extends StatefulWidget {
  const ManagerSettingsPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagerSettingsPage> createState() => _ManagerSettingsPageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];
class _ManagerSettingsPageState extends State<ManagerSettingsPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(),
      drawer: ManagerSectionDrawer(
          currentPage: ManagerDrawerPage.settings,
          managerEntity: widget.managerEntity,
          enterpriseId: _enterpriseId),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}