import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../user_module/domain/entities/operator_entity.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';
import '../components/visibility_icon_component.dart';
import '../controllers/login_controller.dart';
import '../stores/login_store.dart';

class EnterpriseAuthPage extends StatefulWidget {
  const EnterpriseAuthPage({super.key});

  @override
  State<EnterpriseAuthPage> createState() => _EnterpriseAuthPageState();
}

final _loginFormKey = GlobalKey<FormState>();
final _loginStore = Modular.get<LoginStore>();
final _loginController = Modular.get<LoginController>();
final _userLogin = OperatorEntity();
bool _passwordVisible = false;

class _EnterpriseAuthPageState extends State<EnterpriseAuthPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.onSurface;
    final surface = Theme.of(context).colorScheme.surface;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: primaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                Text('Cash Helper',
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: height * 0.25),
                Stack(
                  children: [
                    Card(
                      color: seccondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: SizedBox(
                        height: height * 0.2,
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 30),
                          child: Form(
                            key: _loginFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: CashHelperTextFieldComponent(
                                primaryColor: surfaceColor,
                                suffixIcon: VisibilityIconComponent(
                                    iconColor: surfaceColor,
                                    onTap: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    forVisibility: Icons.visibility,
                                    forHideContent: Icons.visibility_off,
                                    condition: _passwordVisible),
                                radius: 15,
                                obscureText:
                                    _passwordVisible == true ? false : true,
                                validator: (value) =>
                                    _loginController.passwordValidate(value),
                                onSaved: (value) =>
                                    _userLogin.operatorPassword = value,
                                controller: _loginController.passwordField,
                                label: 'Código da Empresa',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.15),
                      child: Center(
                        child: TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () {},
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
                  padding: EdgeInsets.only(top: height * 0.22),
                  child: Visibility(
                    visible: !_loginController.loadingData,
                    replacement: Center(
                      child: CircularProgressIndicator(
                        color: indicatorColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sua empresa não é cadastrada?",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: surface),
                        ),
                        SizedBox(height: height * 0.02),
                        CashHelperElevatedButton(
                          onPressed: () {
                            Modular.to
                                .pushNamed(EnterpriseRoutes.enterpriseFormulary);
                          },
                          radius: 12,
                          width: width,
                          height: 65,
                          buttonName: 'Cadastre-se já!',
                          fontSize: 15,
                          nameColor: surfaceColor,
                          backgroundColor: seccondaryColor,
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
    );
  }
}
