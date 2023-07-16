import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/pendency_states.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/manager_section_drawer.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../management_module/presenter/components/pendencies_information_card.dart.dart';
import '../../../domain/entities/manager_entity.dart';
import '../../components/buttons/manager_view_button.dart';
import '../../../../management_module/presenter/components/payment_methods_information_card.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];
final _managementController = Modular.get<ManagementController>();

class _ManagementPageState extends State<ManagementPage> {
  @override
  void initState() {
    super.initState();
    _managementController.enterpriseId = _enterpriseId;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    return ValueListenableBuilder(
        valueListenable: _managementController.pendenciesListStore,
        builder: (_, state, __) {
          if (state is LoadingPendenciesState) {
            _managementController.getAllPendencies();
            return Container(
              height: height,
              decoration: BoxDecoration(color: appThemes.primaryColor(context)),
              child: Center(
                child: CircularProgressIndicator(
                  color: appThemes.indicatorColor(context),
                ),
              ),
            );
          }
          if (state is NoPendenciesState) {
            return Container(
              decoration: BoxDecoration(color: appThemes.primaryColor(context)),
              child: Center(
                child: Text(
                  "Sem pendências no momento",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            );
          }
          if (state is PendenciesListState) {
            final pendingOperatorsIdList = state.pendencies.map((pendency) => pendency.operatorId).toList();
            final pendingOperators = state.operators.where((operatorEntity) => pendingOperatorsIdList.contains(operatorEntity.operatorId)).toList();
            return Scaffold(
              appBar: AppBar(),
              drawer: ManagerSectionDrawer(
                currentPage: ManagerDrawerPage.management,
                managerEntity: widget.managerEntity,
                enterpriseId: _enterpriseId,
              ),
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: appThemes.backgroundColor(context),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: sizeFrame ? height * 0.16 : height * 0.15,
                            decoration: BoxDecoration(
                              color: appThemes.primaryColor(context),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.09,
                            child: Text(
                              "Gerenciamento",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: SizedBox(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Text(
                                "Métodos de Pagamento:",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              PaymentMethodsInformationCard(enterpriseId: _enterpriseId),
                              const SizedBox(
                                height: 15,
                              ),
                              ManagerViewButton(
                                text: "Visualizar",
                                onPressed: () => Modular.to.pushNamed(
                                  "${ManagementRoutes.paymentMethodsPage}$_enterpriseId",
                                  arguments: widget.managerEntity,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.035,
                              ),
                              Text(
                                "Pendências:",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              PendenciesInformationCard(
                                height: height,
                                enterpriseId: _enterpriseId,
                                pendencies: state.pendencies,
                                operators: pendingOperators,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ManagerViewButton(
                                text: "Visualizar",
                                onPressed: () => Modular.to.pushNamed(
                                  "${ManagementRoutes.pendenciesListPage}$_enterpriseId",
                                  arguments: {
                                    "manager": widget.managerEntity,
                                    "pendenciesList": state.pendencies,
                                    "operatorsList": pendingOperators,
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
