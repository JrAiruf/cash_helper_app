import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../enterprise_module/domain/entities/payment_method_entity.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../../../management_module/presenter/controller/management_controller.dart';
import '../../../management_module/presenter/stores/payment_methods_list_store.dart';
import '../stores/annotations_store.dart';

class CreateAnnotationsPage extends StatefulWidget {
  CreateAnnotationsPage({super.key, required this.operatorEntity});
  OperatorEntity operatorEntity;
  @override
  State<CreateAnnotationsPage> createState() => _CreateAnnotationsPageState();
}

final _newAnnotationFormKey = GlobalKey<FormState>();
final _annotationsController = Modular.get<AnnotationsController>();
final _annotationsStore = Modular.get<AnnotationStore>();
final _managementController = Modular.get<ManagementController>();
final _paymentMethodListStore = Modular.get<PaymentMethodsListStore>();
final _enterpriseId = Modular.args.params["enterpriseId"];
String _paymentMethod = "";
final _newAnnotation = AnnotationEntity();

class _CreateAnnotationsPageState extends State<CreateAnnotationsPage> {
  @override
  void initState() {
    super.initState();
    _paymentMethodListStore.getAllPaymentMethods(_enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final minutesDateTime = DateTime.now().minute;
    final hoursDateTime = DateTime.now().hour;
    final annotationHour =
        '${hoursDateTime >= 10 ? hoursDateTime : '0$hoursDateTime'}:${minutesDateTime >= 10 ? minutesDateTime : '0$minutesDateTime'}';
    final _currentTimeInHours = annotationHour.padLeft(9, "   ");
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
      body: SingleChildScrollView(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: primaryColor,
                    ),
                    width: width,
                    height: height * 0.2,
                  ),
                  Positioned(
                    top: 80,
                    left: 25,
                    child: Text(
                      "Criar Anotação",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: surfaceColor,
                          ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dados da anotação:",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: surfaceColor,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: height * 0.45,
                        width: width * 0.96,
                        child: Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Form(
                            key: _newAnnotationFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CashHelperTextFieldComponent(
                                    textColor: surfaceColor,
                                    primaryColor: surfaceColor,
                                    radius: 15,
                                    validator: (value) => _annotationsController
                                        .annotationAddressValidate(value),
                                    onSaved: (value) => _newAnnotation
                                        .annotationClientAddress = value,
                                    controller: _annotationsController
                                        .annotationAddressField,
                                    label: 'Endereço',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: surfaceColor,
                                    primaryColor: surfaceColor,
                                    radius: 15,
                                    validator: (value) => _annotationsController
                                        .annotationValueValidate(value),
                                    onSaved: (value) => _newAnnotation
                                        .annotationSaleValue = value,
                                    controller:
                                        _annotationsController.annotationValue,
                                    label: 'Valor',
                                  ),
                                  AnimatedBuilder(
                                    animation: _paymentMethodListStore,
                                    builder: (_, __) {
                                      return DropdownButtonFormField<
                                              PaymentMethodEntity>(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: surfaceColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: surfaceColor),
                                            ),
                                          ),
                                          validator: _managementController
                                              .paymentMethodValidate,
                                          onSaved: (value) => _paymentMethod =
                                              value?.paymentMethodId ?? "",
                                          onChanged: (value) => _paymentMethod =
                                              value?.paymentMethodId ?? "",
                                          hint: Text(
                                            "Selecione o método de pagamento",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(color: surfaceColor),
                                          ),
                                          items: _paymentMethodListStore.value
                                              ?.map(
                                                (paymentMethod) =>
                                                    DropdownMenuItem(
                                                  value: paymentMethod,
                                                  child: Text(
                                                    paymentMethod
                                                            .paymentMethodName ??
                                                        "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                        ?.copyWith(
                                                            color:
                                                                surfaceColor),
                                                  ),
                                                ),
                                              )
                                              .toList());
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CashHelperTextFieldComponent(
                                          enable: false,
                                          readOnly: true,
                                          textColor: surfaceColor,
                                          primaryColor: surfaceColor,
                                          radius: 15,
                                          label: 'Hora da Compra:',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CashHelperTextFieldComponent(
                                          controller: _annotationsController
                                              .annotationSaleTime,
                                          enable: false,
                                          readOnly: true,
                                          textColor: surfaceColor,
                                          primaryColor: surfaceColor,
                                          radius: 15,
                                          onSaved: (value) => _newAnnotation
                                              .annotationSaleTime = value,
                                          initialValue: _currentTimeInHours,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.11),
                      Center(
                        child: CashHelperElevatedButton(
                          buttonName: "Criar Anotação",
                          backgroundColor: tertiaryColor,
                          border: true,
                          height: 50,
                          width: width * 0.7,
                          radius: 12,
                          onPressed: () async {
                            _newAnnotationFormKey.currentState?.validate();
                            _newAnnotationFormKey.currentState?.save();
                            _newAnnotation.annotationPaymentMethod =
                                _paymentMethod;
                            await _annotationsStore.createNewAnnotation(
                                _enterpriseId,
                                widget.operatorEntity.operatorId!,
                                _newAnnotation);
                            final model =
                                AnnotationModel.fromEntityData(_newAnnotation);
                            print(model.toMap());
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
  }
}
