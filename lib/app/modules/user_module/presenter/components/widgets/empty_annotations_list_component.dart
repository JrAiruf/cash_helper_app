import 'package:flutter/material.dart';

import '../buttons/quick_access_button.dart';

class EmptyAnnotationsListComponent extends StatelessWidget {
  const EmptyAnnotationsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "Últimas anotações:",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: surfaceColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: SizedBox(
            height: height * 0.2,
            child: Center(
              child: Text(
                "Sem Anotações no momento",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: surfaceColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
