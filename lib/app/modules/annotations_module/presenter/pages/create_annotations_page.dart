// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/date_values/date_values.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../enterprise_module/domain/entities/payment_method_entity.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../../../management_module/presenter/controller/management_controller.dart';
import '../../../management_module/presenter/stores/payment_methods_list_store.dart';

class CreateAnnotationsPage extends StatefulWidget {
  CreateAnnotationsPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;

  @override
  State<CreateAnnotationsPage> createState() => _CreateAnnotationsPageState();
}

final _annotationsController = Modular.get<AnnotationsController>();
final _managementController = Modular.get<ManagementController>();
final _paymentMethodListStore = Modular.get<PaymentMethodsListStore>();

class _CreateAnnotationsPageState extends State<CreateAnnotationsPage> {
  @override
  void initState() {
    super.initState();
    _annotationsController.enterpriseId = Modular.args.params["enterpriseId"];
    _annotationsController.operatorId = widget.operatorEntity.operatorId!;
    _paymentMethodListStore
        .getAllPaymentMethods(_annotationsController.enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dateValue = DateValues();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.navigate(
              "${UserRoutes.operatorHomePage}${_annotationsController.enterpriseId}",
              arguments: widget.operatorEntity),
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
          child: AnimatedBuilder(
            animation: _annotationsController.annotationLoadingState,
            builder: (_, __) {
              return Visibility(
                visible: !_annotationsController.annotationLoadingState.value,
                replacement: Center(
                  child: CircularProgressIndicator(
                    color: indicatorColor,
                  ),
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
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: surfaceColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dados da anotação:",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
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
                                  key: _annotationsController
                                      .newAnnotationFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CashHelperTextFieldComponent(
                                          textColor: surfaceColor,
                                          primaryColor: surfaceColor,
                                          radius: 15,
                                          validator: _annotationsController
                                              .annotationAddressValidate,
                                          onSaved: (value) =>
                                              _annotationsController
                                                  .annotationAddressField
                                                  .text = value!,
                                          controller: _annotationsController
                                              .annotationAddressField,
                                          label: 'Endereço',
                                        ),
                                        CashHelperTextFieldComponent(
                                          textColor: surfaceColor,
                                          primaryColor: surfaceColor,
                                          radius: 15,
                                          validator: _annotationsController
                                              .annotationValueValidate,
                                          onSaved: (value) =>
                                              _annotationsController
                                                  .annotationValueField
                                                  .text = value!,
                                          controller: _annotationsController
                                              .annotationValueField,
                                          label: 'Valor',
                                        ),
                                        AnimatedBuilder(
                                          animation: _paymentMethodListStore,
                                          builder: (_, __) {
                                            return DropdownButtonFormField<
                                                PaymentMethodEntity>(
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: surfaceColor,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: surfaceColor,
                                                  ),
                                                ),
                                              ),
                                              validator: _managementController
                                                  .paymentMethodValidate,
                                              onSaved: (value) =>
                                                  _annotationsController
                                                          .annotationPaymentMethodField
                                                          .text =
                                                      value!.paymentMethodName!,
                                              onChanged: (value) => value,
                                              hint: Text(
                                                "Selecione o método de pagamento",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall
                                                    ?.copyWith(
                                                      color: surfaceColor,
                                                    ),
                                              ),
                                              items: _paymentMethodListStore
                                                  .value
                                                  ?.map(
                                                    (paymentMethod) =>
                                                        DropdownMenuItem(
                                                      value: paymentMethod,
                                                      child: Text(
                                                        paymentMethod
                                                            .paymentMethodName!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                            ?.copyWith(
                                                              color:
                                                                  surfaceColor,
                                                            ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            );
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child:
                                                  CashHelperTextFieldComponent(
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
                                              child:
                                                  CashHelperTextFieldComponent(
                                                controller:
                                                    _annotationsController
                                                        .annotationSaleTimeField,
                                                enable: false,
                                                readOnly: true,
                                                textColor: surfaceColor,
                                                primaryColor: surfaceColor,
                                                radius: 15,
                                                onSaved: (value) =>
                                                    _annotationsController
                                                        .annotationSaleTimeField
                                                        .text = value!,
                                                initialValue: dateValue
                                                    .annotationHourDateTime,
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
                                onPressed: () => _annotationsController
                                    .createAnnotation(widget.operatorEntity),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
