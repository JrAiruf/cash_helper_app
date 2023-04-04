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
      this.isButton,
      this.textColor,
      this.radius,
      this.height,
      this.width,
      this.hint,
      this.label,
      this.validator,
      this.onValidate});

  final IconData? icon;
  final IconData? suffixIcon;
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
  final bool? isButton;
  final bool? readOnly;
  final TextEditingController? controller;
  final TextInputType? input;
  final String? hint;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      child: TextFormField(
        enabled: enable ?? true,
        onTap: onTap,
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(
          color: primaryColor ?? Colors.white,
        ),
        decoration: InputDecoration(
          fillColor: primaryColor?.withOpacity(0.6),
          enabled: readOnly == true ? false : true,
          errorStyle: Theme.of(context).textTheme.bodySmall,
          labelStyle: TextStyle(color: primaryColor ?? Colors.white),
          hintText: hint ?? '',
          label: Text(
            label ?? '',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
            borderSide: BorderSide(
                color: primaryColor ?? Colors.white.withOpacity(0.2),
                width: 0.9),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
            borderSide: BorderSide(color: primaryColor ?? Colors.white),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor ?? Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
            borderSide: BorderSide(color: primaryColor ?? Colors.white),
          ),
          prefixIcon: Icon(
            icon,
            color: primaryColor ?? Colors.white,
          ),
          suffixIcon: GestureDetector(
            onTap: iconTap,
            child: Icon(
              suffixIcon,
              color: primaryColor ?? Colors.white,
            ),
          ),
        ),
        keyboardType: input,
      ),
    );
  }
}
