import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../components/buttons/cash_helper_login_button.dart';

class UserRedirectionPage extends StatefulWidget {
  const UserRedirectionPage({super.key});

  @override
  State<UserRedirectionPage> createState() => _UserRedirectionPageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];

class _UserRedirectionPageState extends State<UserRedirectionPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: appThemes.primaryColor(context),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Esqueceu sua senha?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: appThemes.surfaceColor(context),
                    ),
              ),
              SizedBox(height: height * 0.1),
              Text(
                "Não tem nenhum problema! Nós te ajudaremos a recuperá-la já já.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: appThemes.surfaceColor(context),
                    ),
              ),
              SizedBox(height: height * 0.4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Qual é a sua ocupação?",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CashHelperElevatedButton(
                        border: true,
                        backgroundColor: appThemes.greenColor(context),
                        buttonName: "Operador",
                        fontSize: 18,
                        radius: 5,
                        onPressed: () {
                          Modular.to.navigate("/forgot-password-page/$_enterpriseId", arguments: "operator");
                        },
                        width: width * 0.45,
                      ),
                      CashHelperElevatedButton(
                        border: true,
                        backgroundColor: appThemes.blueColor(context),
                        buttonName: "Gerente",
                        fontSize: 18,
                        radius: 5,
                        onPressed: () {
                          Modular.to.navigate("/forgot-password-page/$_enterpriseId", arguments: "manager");
                        },
                        width: width * 0.45,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
