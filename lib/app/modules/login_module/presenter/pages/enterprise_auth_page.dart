import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../enterprise_module/presenter/controller/enterprise_controller.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';
import '../components/visibility_icon_component.dart';
import '../controllers/login_controller.dart';

class EnterpriseAuthPage extends StatefulWidget {
  const EnterpriseAuthPage({super.key});

  @override
  State<EnterpriseAuthPage> createState() => _EnterpriseAuthPageState();
}

final _loginController = Modular.get<LoginController>();
final _enterpriseController = Modular.get<EnterpriseController>();

class _EnterpriseAuthPageState extends State<EnterpriseAuthPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: appThemes.primaryColor(context)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: AnimatedBuilder(
              animation: _enterpriseController.loadingEnterpriseAuth,
              builder: (_, __) {
                return Visibility(
                  visible: !_enterpriseController.loadingEnterpriseAuth.value,
                  replacement: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                    child: Center(
                      child: Stack(
                        children: [
                          Positioned(
                            top: height * 0.1,
                            child: Text('Cash Helper', style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              color: appThemes.indicatorColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.1),
                      Text('Cash Helper', style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: height * 0.25),
                      Stack(
                        children: [
                          Card(
                            color: appThemes.purpleColor(context),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              height: height * 0.22,
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                                child: Form(
                                  key: _enterpriseController.enterpriseFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: AnimatedBuilder(
                                        animation: _enterpriseController.codeVisible,
                                        builder: (_, __) {
                                          return CashHelperTextFieldComponent(
                                            primaryColor: appThemes.surfaceColor(context),
                                            suffixIcon: VisibilityIconComponent(
                                                iconColor: appThemes.surfaceColor(context),
                                                onTap: () => _enterpriseController.codeVisible.value = !_enterpriseController.codeVisible.value,
                                                forVisibility: Icons.visibility,
                                                forHideContent: Icons.visibility_off,
                                                condition: _enterpriseController.codeVisible.value),
                                            radius: 15,
                                            obscureText: _enterpriseController.codeVisible.value ? false : true,
                                            validator: _loginController.enterpriseCodeValidate,
                                            onSaved: (value) => _enterpriseController.enterpriseCodeField.text = value!,
                                            controller: _enterpriseController.enterpriseCodeField,
                                            label: 'Código da Empresa',
                                          );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.16),
                            child: Center(
                              child: TextButton(
                                style: TextButton.styleFrom(),
                                onPressed: () => _enterpriseController.authenticateEnterprise(context),
                                child: Text(
                                  'Autenticar Empresa',
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sua empresa não é cadastrada?",
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                    color: appThemes.surfaceColor(context),
                                  ),
                            ),
                            SizedBox(height: height * 0.02),
                            CashHelperElevatedButton(
                              onPressed: () => Modular.to.pushNamed(EnterpriseRoutes.enterpriseFormulary),
                              radius: 12,
                              width: width,
                              height: 65,
                              buttonName: 'Cadastre-se já!',
                              fontSize: 15,
                              nameColor: appThemes.surfaceColor(context),
                              backgroundColor: appThemes.purpleColor(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
