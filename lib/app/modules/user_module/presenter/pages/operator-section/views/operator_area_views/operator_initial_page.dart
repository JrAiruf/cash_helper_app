import 'package:cash_helper_app/app/modules/user_module/presenter/components/operator_widgets/cash_number_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../../shared/themes/cash_helper_themes.dart';
import '../../../../../../annotations_module/domain/entities/annotation_entity.dart';
import '../../../../../../enterprise_module/domain/entities/payment_method_entity.dart';
import '../../../../../../management_module/presenter/stores/payment_methods_list_store.dart';
import '../../../../../domain/entities/operator_entity.dart';
import '../../../../components/cash_helper_bottom_navigation_bar.dart';
import '../../../../components/widgets/annotations_list_view_component.dart';

class OperatorInitialPage extends StatefulWidget {
  const OperatorInitialPage({super.key, required this.operatorEntity, this.position, required this.pageController, required this.annotations, required this.enterpriseId});
  final List<AnnotationEntity> annotations;
  final OperatorEntity operatorEntity;
  final BottomNavigationBarPosition? position;
  final PageController? pageController;
  final String enterpriseId;
  @override
  State<OperatorInitialPage> createState() => _OperatorInitialtate();
}

class _OperatorInitialtate extends State<OperatorInitialPage> {
  bool _doneAnnotations = true;
  final _listTypeController = PageController();
  final _paymentMethodsStore = Modular.get<PaymentMethodsListStore>();
  String paymentMethod = "";
  @override
  void initState() {
    super.initState();
    _paymentMethodsStore.getAllPaymentMethods(widget.enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final notFinishedAnnotations = widget.annotations.where(((element) => element.annotationConcluied == false && element.annotationPaymentMethod == paymentMethod)).toList();
    final finishedAnnotations = widget.annotations.where(((element) => element.annotationConcluied == true && element.annotationPaymentMethod == paymentMethod)).toList();
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: appThemes.backgroundColor(context),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: height * 0.15,
              decoration: BoxDecoration(
                color: appThemes.primaryColor(context),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            widthFactor: width,
            child: SizedBox(
              height: height * 0.65,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.27),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _doneAnnotations ? "Finalizadas" : "Não Finalizadas",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: appThemes.surfaceColor(context),
                                ),
                          ),
                          SizedBox(
                            height: sizeFrame ? height * 0.08 : height * 0.06,
                            width: width * 0.3,
                            child: AnimatedBuilder(
                                animation: _paymentMethodsStore,
                                builder: (context, _) {
                                  return DropdownButtonFormField<PaymentMethodEntity>(
                                    borderRadius: BorderRadius.circular(15),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: appThemes.surfaceColor(context),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: appThemes.surfaceColor(context),
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        paymentMethod = value!.paymentMethodName!;
                                      });
                                    },
                                    hint: Text(
                                      "Filtrar",
                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                            color: appThemes.surfaceColor(context),
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    items: _paymentMethodsStore.value
                                        ?.map(
                                          (paymentMethod) => DropdownMenuItem(
                                            value: paymentMethod,
                                            child: Text(
                                              paymentMethod.paymentMethodName!,
                                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                                    color: appThemes.surfaceColor(context),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.035),
                    SizedBox(
                      height: height * 0.25,
                      child: PageView(
                        controller: _listTypeController,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          AnnoationsListViewComponent(
                              borderColor: appThemes.surfaceColor(context),
                              seccundaryColor: appThemes.surfaceColor(context),
                              backgroundColor: appThemes.primaryColor(context),
                              itemWidth: sizeFrame ? width * 0.33 : width * 0.4,
                              itemHeight: sizeFrame ? height * 0.025 : height * 0.033,
                              annotations: finishedAnnotations),
                          AnnoationsListViewComponent(
                              borderColor: appThemes.surfaceColor(context),
                              seccundaryColor: appThemes.surfaceColor(context),
                              backgroundColor: appThemes.primaryColor(context),
                              itemWidth: width * 0.4,
                              annotations: notFinishedAnnotations),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: sizeFrame ? height * 0.11 : height * 0.12,
            left: width * 0.02,
            child: SizedBox(
              width: width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CashNumberComponent(operatorEntity: widget.operatorEntity, backgroundColor: appThemes.surfaceColor(context), radius: 16),
                  Text(
                    "${widget.operatorEntity.operatorName}",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.245,
            left: 2,
            child: Switch(
              activeColor: appThemes.greenColor(context),
              value: _doneAnnotations,
              onChanged: (value) {
                setState(
                  () {
                    _doneAnnotations = !_doneAnnotations;
                    _listTypeController.animateToPage(_doneAnnotations ? 0 : 1, duration: const Duration(milliseconds: 400), curve: Curves.linear);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
