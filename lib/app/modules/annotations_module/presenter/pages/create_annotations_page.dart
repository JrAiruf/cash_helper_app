import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../login_module/presenter/stores/login_states.dart';

class CreateAnnotationsPage extends StatefulWidget {
  const CreateAnnotationsPage({super.key, required this.operatorId});
  final String operatorId;
  @override
  State<CreateAnnotationsPage> createState() => _CreateAnnotationsPageState();
}

final _loginStore = Modular.get<LoginStore>();

class _CreateAnnotationsPageState extends State<CreateAnnotationsPage> {
  @override
  void initState() {
    _loginStore.getOperatorById("",widget.operatorId, "operator");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    return ValueListenableBuilder(
        valueListenable: _loginStore,
        builder: (_, pageState, __) {
          if (pageState is LoginLoadingState) {
            return Container(
              decoration: BoxDecoration(color: primaryColor),
              child: Center(
                child: CircularProgressIndicator(
                  color: indicatorColor,
                ),
              ),
            );
          }
          if (pageState is LoginSuccessState) {
            final operatorEntity = pageState.operatorEntity;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Modular.to.navigate("/operator-module/",
                          arguments: operatorEntity);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              body: Container(
                decoration: BoxDecoration(color: primaryColor),
                child: Center(child: Column()),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Modular.to.navigate("");
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: const SizedBox(
              child: Center(
                child: Text("Create Annotations Page"),
              ),
            ),
          );
        });
  }
}
