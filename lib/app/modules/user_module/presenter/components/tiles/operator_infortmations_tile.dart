// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OperatorInformationsTile extends StatelessWidget {
  OperatorInformationsTile({
    Key? key,
    required this.content,
    required this.icon,
  });

  final String? content;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.surface;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon),
        Text(
          content ?? "",
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: textColor),
        ),
      ],
    );
  }
}
