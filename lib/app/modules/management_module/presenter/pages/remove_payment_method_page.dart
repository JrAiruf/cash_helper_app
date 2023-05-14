import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../user_module/domain/entities/manager_entity.dart';

class RemovePaymentMethodPage extends StatefulWidget {
  const RemovePaymentMethodPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<RemovePaymentMethodPage> createState() =>
      _RemovePaymentMethodPageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];

class _RemovePaymentMethodPageState extends State<RemovePaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final errorColor = Theme.of(context).colorScheme.errorContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: height,
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  child: Text(
                    "Métodos de Pagamento",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Text(
                      "Criar novo método:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: surfaceColor),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Center(
                      child: Column(
                        children: [
                          CashHelperElevatedButton(
                            radius: 10,
                            onPressed: () {},
                            border: true,
                            backgroundColor: tertiaryColor,
                            height: 50,
                            width: width * 0.7,
                            buttonName: "Salvar",
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CashHelperElevatedButton(
                            radius: 10,
                            onPressed: () {
                              Modular.to.navigate(
                                  "${UserRoutes.managementPage}$_enterpriseId",
                                  arguments: widget.managerEntity);
                            },
                            border: true,
                            backgroundColor: primaryColor,
                            nameColor: surfaceColor,
                            height: 50,
                            width: width * 0.7,
                            buttonName: "Voltar",
                            fontSize: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
