// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/themes/cash_helper_themes.dart';
import '../../../../routes/app_routes.dart';

class AnnotationsListPage extends StatefulWidget {
  AnnotationsListPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<AnnotationsListPage> createState() => _AnnotationsListPageState();
}

String _enterpriseId = "";
final _annotationsListStore = Modular.get<AnnotationsListStore>();

class _AnnotationsListPageState extends State<AnnotationsListPage> {
  @override
  void initState() {
    super.initState();
    _enterpriseId = Modular.args.params["enterpriseId"];
    _annotationsListStore.getAllAnnotations(
        _enterpriseId, widget.operatorEntity.operatorId!);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Modular.to.navigate("${UserRoutes.operatorHomePage}$_enterpriseId",
                arguments: widget.operatorEntity);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        height: height * 0.65,
        width: width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: appTheme.backgroundColor(context),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: appTheme.primaryColor(context),
        ),
      ),
    );
  }
}