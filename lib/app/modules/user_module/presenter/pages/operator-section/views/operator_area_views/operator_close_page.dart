import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../routes/app_routes.dart';
import '../../../../../domain/entities/operator_entity.dart';
import '../../../../components/tiles/operator_infortmations_tile.dart';

class OperatorClosePage extends StatefulWidget {
  const OperatorClosePage({super.key, required this.operatorEntity});

  final OperatorEntity operatorEntity;

  @override
  State<OperatorClosePage> createState() => _OperatorClosePageState();
}

final enterpriseId = Modular.args.params["enterpriseId"];

class _OperatorClosePageState extends State<OperatorClosePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    String oppeningTime = widget.operatorEntity.operatorOppening == "Pendente" ? "Pendente" : widget.operatorEntity.operatorOppening ?? "";
    String operatorStatus = widget.operatorEntity.operatorEnabled! ? "Ativo" : "Inativo";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () => Modular.to.navigate(
            "${UserRoutes.operatorHomePage}$enterpriseId",
            arguments: widget.operatorEntity,
          ),
        ),
      ),
      body: Container(
        height: height,
        decoration: BoxDecoration(
          color: appThemes.backgroundColor(context),
        ),
        child: Stack(
          children: [
            Container(
              height: height * 0.15,
              width: width,
              decoration: BoxDecoration(
                color: appThemes.primaryColor(context),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 55,
                    ),
                    Text(
                      widget.operatorEntity.operatorName ?? "",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: appThemes.surfaceColor(context),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: sizeFrame ? height * 0.23 : height * 0.22,
              child: SizedBox(
                height: sizeFrame ? height * 0.65 : height * 0.75,
                width: width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: sizeFrame ? height * 0.1 : height * 0.09,
                          decoration: BoxDecoration(
                            color: appThemes.primaryColor(context),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OperatorInformationsTile(
                                  content: operatorStatus,
                                  icon: Icons.power_settings_new_rounded,
                                ),
                                OperatorInformationsTile(
                                  content: oppeningTime,
                                  icon: Icons.access_time,
                                ),
                                OperatorInformationsTile(
                                  content: "${widget.operatorEntity.operatorNumber}",
                                  icon: Icons.monitor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
