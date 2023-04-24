import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateAnnotationsPage extends StatefulWidget {
  const CreateAnnotationsPage({super.key, required this.operatorId});
  final String operatorId;
  @override
  State<CreateAnnotationsPage> createState() => _CreateAnnotationsPageState();
}

class _CreateAnnotationsPageState extends State<CreateAnnotationsPage> {
  @override
  Widget build(BuildContext context) {
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
  }
}
