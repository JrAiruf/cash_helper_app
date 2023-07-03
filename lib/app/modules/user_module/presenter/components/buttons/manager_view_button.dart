import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';

class ManagerViewButton extends StatelessWidget {
  const ManagerViewButton({required this.onPressed, super.key});

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.05,
      width: width * 0.4,
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: appThemes.blueColor(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: appThemes.whiteColor(context),
          ),
          backgroundColor: appThemes.blueColor(context),
        ),
        onPressed: onPressed,
        child: Text(
          "Visualizar",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
