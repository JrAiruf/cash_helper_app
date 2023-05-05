import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../domain/entities/enterprise_entity.dart';

class EnterpriseCreatedPage extends StatefulWidget {
  const EnterpriseCreatedPage({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<EnterpriseCreatedPage> createState() => _EnterpriseCreatedPageState();
}

class _EnterpriseCreatedPageState extends State<EnterpriseCreatedPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: primaryColor),
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: height * 0.07,
              ),
              child: Text('Cash Helper',
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            SizedBox(height: height * 0.12),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sua conta empresarial foi criada \n usando o email:",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.1),
                  Text(
                    widget.enterpriseEntity.enterpriseEmail ?? "",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: height * 0.25),
                  Text(
                    "Crie um usuário administrativo \n para gerenciar sua conta",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.11),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: CashHelperElevatedButton(
                      onPressed: () {
                        Modular.to.navigate(LoginRoutes.createManager,
                            arguments: widget.enterpriseEntity);
                      },
                      width: width,
                      height: 65,
                      buttonName: 'Próximo',
                      fontSize: 15,
                      nameColor: Colors.white,
                      backgroundColor: seccondaryColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
