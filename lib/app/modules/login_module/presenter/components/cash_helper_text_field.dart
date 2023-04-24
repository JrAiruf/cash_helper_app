import 'package:flutter/material.dart';

class CashHelperTextFieldComponent extends StatelessWidget {
  const CashHelperTextFieldComponent(
      {super.key,
      this.icon,
      this.suffixIcon,
      this.primaryColor,
      this.errorColor,
      this.onPressed,
      this.onChanged,
      this.obscureText,
      this.readOnly,
      this.controller,
      this.input,
      this.enable,
      this.onSaved,
      this.onTap,
      this.iconTap,
      this.textColor,
      this.radius,
      this.height,
      this.width,
      this.hint,
      this.label,
      this.validator,
      this.onValidate});

  final Widget? icon;
  final Widget? suffixIcon;
  final Color? primaryColor;
  final Color? errorColor;
  final Color? textColor;
  final double? radius;
  final double? height;
  final double? width;
  final void Function()? onPressed;
  final String? Function(String?)? onChanged;
  final void Function()? onTap;
  final void Function()? iconTap;
  final void Function()? onValidate;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool? obscureText;
  final bool? enable;
  final bool? readOnly;
  final TextEditingController? controller;
  final TextInputType? input;
  final String? hint;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return TextFormField(
      textInputAction: TextInputAction.go,
      enabled: enable ?? true,
      onTap: onTap,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: primaryColor ?? surfaceColor,
      ),
      decoration: InputDecoration(
        enabled: readOnly == true ? false : true,
        errorStyle:
            TextStyle(color: primaryColor ?? surfaceColor, fontSize: 12),
        labelStyle: TextStyle(color: primaryColor ?? surfaceColor),
        hintText: hint ?? '',
        label: Text(
          label ?? '',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: primaryColor ?? surfaceColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: BorderSide(
              color: primaryColor ?? surfaceColor.withOpacity(0.2), width: 0.9),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: BorderSide(color: primaryColor ?? surfaceColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: primaryColor ?? surfaceColor.withOpacity(0.2), width: 0.9),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: BorderSide(color: primaryColor ?? surfaceColor),
        ),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: input,
    );
  }
}
