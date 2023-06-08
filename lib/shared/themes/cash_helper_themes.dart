// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CashHelperThemes {
  Color Function(BuildContext context) get primaryColor => (BuildContext context) => Theme.of(context).colorScheme.primary;
  Color Function(BuildContext context) get backgroundColor => (BuildContext context) => Theme.of(context).colorScheme.onBackground;
  Color Function(BuildContext context) get surfaceColor => (BuildContext context) => Theme.of(context).colorScheme.surface;
  Color Function(BuildContext context) get purpleColor => (BuildContext context) => Theme.of(context).colorScheme.secondary;
  Color Function(BuildContext context) get greenColor => (BuildContext context) => Theme.of(context).colorScheme.tertiaryContainer;
  Color Function(BuildContext context) get redColor => (BuildContext context) => Theme.of(context).colorScheme.errorContainer;
  Color Function(BuildContext context) get violetColor => (BuildContext context) => Theme.of(context).colorScheme.tertiary;
  Color Function(BuildContext context) get red => (BuildContext context) => Theme.of(context).colorScheme.onError;
  Color Function(BuildContext context) get indicatorColor => (BuildContext context) => Theme.of(context).colorScheme.secondaryContainer;
}
