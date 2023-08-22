import 'package:flutter/material.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';

class RegistrationLoadingPage extends StatefulWidget {
  const RegistrationLoadingPage({super.key});

  @override
  State<RegistrationLoadingPage> createState() => _RegistrationLoadingPageState();
}

class _RegistrationLoadingPageState extends State<RegistrationLoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: appThemes.primaryColor(context)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aguarde... ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: appThemes.surfaceColor(context),
                      ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Estamos preparando tudo para você",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: appThemes.surfaceColor(context),
                      ),
                ),
                SizedBox(height: height * 0.02), 
                LinearProgressIndicator(
                  color: appThemes.greenColor(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
