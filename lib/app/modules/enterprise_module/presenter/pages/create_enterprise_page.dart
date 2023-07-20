import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_states.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../routes/app_routes.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../../../login_module/presenter/components/visibility_icon_component.dart';
import '../controller/enterprise_controller.dart';

class CreateEnterprisePage extends StatefulWidget {
  const CreateEnterprisePage({required this.enterpriseEntity, super.key});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<CreateEnterprisePage> createState() => _CreateEnterprisePageState();
}

class _CreateEnterprisePageState extends State<CreateEnterprisePage> {
  final _enterpriseController = Modular.get<EnterpriseController>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    final sizeFrame = height <= 800;

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder(
        bloc: _enterpriseController.createEnterpriseBloc,
        builder: (_, state) {
          if (state is CreateEnterpriseLoadingState) {
            return Container(
              decoration: BoxDecoration(color: appThemes.primaryColor(context)),
              height: height,
              width: width,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            );
          } if (state is CreateEnterpriseErrorState) {
            return Container(
              decoration: BoxDecoration(color: appThemes.primaryColor(context)),
              height: height,
              width: width,
              child: Center(
                child: Text(state.error,style: Theme.of(context).textTheme.bodyMedium,)
              ),
            );
          } if (state is CreateEnterpriseInitialState) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: height * 0.015,
                      ),
                      child: Text('Cash Helper', style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Dados Empresariais', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surface(context))),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: height * 0.35,
                            width: width * 0.95,
                            child: Card(
                              color: appThemes.purpleColor(context),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Form(
                                key: _enterpriseController.createEnterpriseFormKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CashHelperTextFieldComponent(
                                        textColor: appThemes.surfaceColor(context),
                                        primaryColor: appThemes.surfaceColor(context),
                                        radius: 15,
                                        validator: (value) => _enterpriseController.enterpriseEmailValidate(value),
                                        onSaved: (value) => widget.enterpriseEntity.enterpriseEmail = value,
                                        controller: _enterpriseController.enterpriseEmailField,
                                        label: 'E-mail empresarial',
                                      ),
                                      Text('E-mail para uso na aplicação', style: Theme.of(context).textTheme.bodySmall),
                                      const SizedBox(height: 15),
                                      AnimatedBuilder(
                                          animation: _enterpriseController.passwordVisible,
                                          builder: (_, __) {
                                            return CashHelperTextFieldComponent(
                                              textColor: appThemes.surfaceColor(context),
                                              primaryColor: appThemes.surfaceColor(context),
                                              suffixIcon: VisibilityIconComponent(
                                                  iconColor: appThemes.surfaceColor(context),
                                                  onTap: () => _enterpriseController.passwordVisible.value = !_enterpriseController.passwordVisible.value,
                                                  forVisibility: Icons.visibility,
                                                  forHideContent: Icons.visibility_off,
                                                  condition: _enterpriseController.passwordVisible.value),
                                              radius: 15,
                                              validator: (value) => _enterpriseController.passwordValidate(value),
                                              onSaved: (value) => widget.enterpriseEntity.enterprisePassword = value,
                                              controller: _enterpriseController.newEnterprisePasswordField,
                                              obscureText: _enterpriseController.passwordVisible.value ? false : true,
                                              label: 'Senha',
                                            );
                                          }),
                                      AnimatedBuilder(
                                        animation: _enterpriseController.confirmPasswordVisible,
                                        builder: (_, __) {
                                          return CashHelperTextFieldComponent(
                                            textColor: appThemes.surfaceColor(context),
                                            primaryColor: appThemes.surfaceColor(context),
                                            suffixIcon: VisibilityIconComponent(
                                                iconColor: appThemes.surfaceColor(context),
                                                onTap: () => _enterpriseController.confirmPasswordVisible.value = !_enterpriseController.confirmPasswordVisible.value,
                                                forVisibility: Icons.visibility,
                                                forHideContent: Icons.visibility_off,
                                                condition: _enterpriseController.confirmPasswordVisible.value),
                                            radius: 15,
                                            validator: (value) => _enterpriseController.passwordValidate(value),
                                            onSaved: (value) => _enterpriseController.confirmationPassword = value!,
                                            controller: _enterpriseController.cityField,
                                            obscureText: _enterpriseController.confirmPasswordVisible.value ? false : true,
                                            label: 'Confirmar Senha',
                                          );
                                        },
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
                    SizedBox(height: sizeFrame ? height * 0.2 : height * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: CashHelperElevatedButton(
                        onPressed: () {
                          _enterpriseController.finishEnterpriseRegistration(context);
                        },
                        width: width,
                        height: 65,
                        buttonName: 'Próximo',
                        fontSize: 15,
                        nameColor: Colors.white,
                        backgroundColor: appThemes.purpleColor(context),
                      ),
                    )
                  ],
                ),
              ),
            );
          } if (state is CreateEnterpriseSuccessState) {
            final enterprise = state.enterprise;
            Modular.to.pushReplacementNamed(EnterpriseRoutes.enterpriseCreated, arguments: enterprise);
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
