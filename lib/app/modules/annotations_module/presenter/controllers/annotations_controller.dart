// ignore_for_file: use_build_context_synchronously

import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/annotations_bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/annotations_events.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/themes/cash_helper_themes.dart';
import '../../../user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import '../date_values/date_values.dart';
import '../stores/annotations_list_store.dart';
import '../stores/annotations_store.dart';

class AnnotationsController {
  final annotationAddressField = TextEditingController();
  final annotationValueField = TextEditingController();
  final annotationPaymentMethodField = TextEditingController();
  final annotationSaleTimeField = TextEditingController();
  final dateValue = DateValues();
  final _annotationsStore = Modular.get<AnnotationStore>();
  final annotationsBloc = Modular.get<AnnotationsBloc>();
  final annotationsListStore = Modular.get<AnnotationsListStore>();
  final annotationsPageController = PageController();
  final annotationsListPageController = PageController();
  final appTheme = CashHelperThemes();
  String get annotationClientAddress => annotationAddressField.text;

  String get annotationSaleTime => annotationSaleTimeField.text;

  String get annotationPaymentMethod => annotationPaymentMethodField.text;

  String get annotationValue => annotationValueField.text;

  BottomNavigationBarPosition? position;

  final newAnnotationFormKey = GlobalKey<FormState>();
  final annotationLoadingState = ValueNotifier(false);

  String enterpriseId = "";
  String operatorId = "";
  String annotationId = "";
  List<AnnotationEntity> annotationsList = [];
  String? annotationAddressValidate(String? value) {
    return value!.isNotEmpty && value != '' ? null : 'Endereço Inválido! Informe o rua e número.';
  }

  String? annotationValueValidate(String? value) {
    return value!.isNotEmpty && value != '' ? null : 'Valor Inválido! Insira o valor da compra feita.';
  }

  Future<void> createAnnotation(OperatorEntity operatorEntity) async {
    newAnnotationFormKey.currentState!.validate();
    if (newAnnotationFormKey.currentState!.validate()) {
      newAnnotationFormKey.currentState?.save();
      final newAnnotation = AnnotationEntity(
          annotationCreatorId: operatorEntity.operatorId,
          annotationClientAddress: annotationClientAddress,
          annotationConcluied: false,
          annotationWithPendency: false,
          annotationReminder: "AnnotationReminder",
          annotationSaleDate: dateValue.annotationDayDateTime,
          annotationSaleTime: annotationSaleTime,
          annotationPaymentMethod: annotationPaymentMethod,
          annotationId: "AnnotationId",
          annotationSaleValue: annotationValue);
      annotationsBloc.add(CreateAnnotationEvent(enterpriseId, newAnnotation));
      Modular.to.navigate("${AnnotationRoutes.annotationsListPage}$enterpriseId", arguments: operatorEntity);
    } else {
      return;
    }
  }

  Future<void> getAllAnnotations() async {
    annotationsList = annotationsListStore.value;
  }

  Future<void> finishAnnotation(BuildContext context, OperatorEntity operatorEntity) async {
    await _annotationsStore.finishAnnotation(enterpriseId, operatorEntity.operatorId!, annotationId);
    annotationLoadingState.value = false;
    annotationFinished(context);
    Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId", arguments: operatorEntity);
  }

  Future<void> deleteAnnotation(BuildContext context, OperatorEntity operatorEntity) async {
    showRemoveDialog(
      context,
      appTheme.backgroundColor(context),
      () async {
        await _annotationsStore.deleteAnnotation(enterpriseId, operatorEntity.operatorId!, annotationId);
        annotationLoadingState.value = false;
        annotationDeleted(context);
        Modular.to.pop();
        Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId", arguments: operatorEntity);
      },
    );
  }

  annotationFinished(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: appTheme.greenColor(context),
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              'Anotação Finzalizada!',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
    );
  }

  annotationDeleted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: appTheme.red(context),
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              'Anotação Removida!',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
    );
  }

  showRemoveDialog(BuildContext context, Color color, void Function()? onPressed) {
    showDialog(
      context: context,
      builder: (_) {
        final surfaceColor = Theme.of(context).colorScheme.surface;
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Deseja Excluir anotação?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: surfaceColor)),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Sim',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: surfaceColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      style: TextButton.styleFrom(side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Não',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: surfaceColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
