import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../login_module/presenter/stores/login_states.dart';

class CreateAnnotationsPage extends StatefulWidget {
  CreateAnnotationsPage({super.key, required this.operatorEntity});
  OperatorEntity operatorEntity;
  @override
  State<CreateAnnotationsPage> createState() => _CreateAnnotationsPageState();
}

final _loginStore = Modular.get<LoginStore>();

final _enterpriseId = Modular.args.params["enterpriseId"];

class _CreateAnnotationsPageState extends State<CreateAnnotationsPage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Modular.to.navigate(
                  "${UserRoutes.operatorHomePage}$_enterpriseId",
                  arguments: widget.operatorEntity);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        decoration: BoxDecoration(color: primaryColor),
        child: Center(child: Column()),
      ),
    );
  }
}
