// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EnterpriseErrorPage extends StatefulWidget {
  EnterpriseErrorPage({required this.errorText, super.key});

  String errorText;
  @override
  State<EnterpriseErrorPage> createState() => _EnterpriseErrorPageState();
}

class _EnterpriseErrorPageState extends State<EnterpriseErrorPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Modular.to.pushReplacementNamed("/");
            },
            icon: Icon(
              Icons.arrow_back,
              color: appThemes.surfaceColor(context),
            )),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: appThemes.primaryColor(context)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  top: height * 0.1,
                  child: Text('Cash Helper', style: Theme.of(context).textTheme.bodyLarge),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.errorText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                      ),
                    ],
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
