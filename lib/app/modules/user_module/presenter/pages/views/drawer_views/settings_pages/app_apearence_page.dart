// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../../shared/stores/app_store.dart';

class AppAppearencePage extends StatefulWidget {
  AppAppearencePage({super.key, this.position, this.controller});

  BottomNavigationBarPosition? position;
  PageController? controller;

  @override
  State<AppAppearencePage> createState() => _AppAppearencePageState();
}

class _AppAppearencePageState extends State<AppAppearencePage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final store = context.watch<AppStore>((store) => store.appTheme);
    return Container(
      decoration: BoxDecoration(color: primaryColor),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.75,
              decoration: BoxDecoration(
                color: backgroundContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Text(
                "Aparência",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: height * 0.5,
              width: width * 0.84,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.05, width: width),
                  Text(
                    "Tema:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: surfaceColor),
                  ),
                  SizedBox(height: height * 0.06),
                  RadioListTile<ThemeMode>(
                    activeColor: tertiaryColor,
                    value: ThemeMode.light,
                    groupValue: store.appTheme.value,
                    onChanged: (value) {
                      store.appTheme.value = value!;
                    },
                    title: Text(
                      "Claro",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: surfaceColor),
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  RadioListTile<ThemeMode>(
                    activeColor: tertiaryColor,
                    value: ThemeMode.dark,
                    groupValue: store.appTheme.value,
                    onChanged: (value) {
                      store.appTheme.value = value!;
                    },
                    title: Text(
                      "Escuro",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: surfaceColor),
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  RadioListTile<ThemeMode>(
                    activeColor: tertiaryColor,
                    value: ThemeMode.system,
                    groupValue: store.appTheme.value,
                    onChanged: (value) {
                      store.appTheme.value = value!;
                    },
                    title: Text(
                      "Sistema",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: surfaceColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.03,
            left: width * 0.05,
            child: const Icon(
              Icons.color_lens_outlined,
              size: 85,
            ),
          ),
        ],
      ),
    );
  }
}
