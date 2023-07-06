import 'package:flutter/material.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../../domain/entities/pendency_entity.dart';

class PendenciesListPage extends StatefulWidget {
  const PendenciesListPage({super.key});

  @override
  State<PendenciesListPage> createState() => _PendenciesListPageState();
}

List<PendencyEntity> pendencies = [];

class _PendenciesListPageState extends State<PendenciesListPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: appThemes.backgroundColor(context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: sizeFrame ? height * 0.16 : height * 0.15,
                    decoration: BoxDecoration(
                      color: appThemes.primaryColor(context),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.09,
                    child: Text(
                      "Pendências",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        "Operadores:",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: sizeFrame ? height * 0.65 : height * 0.7,
                        child: ListView.builder(
                          itemBuilder: (_, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                              child: Container(
                                height: height * 0.3,
                                width: width,
                                decoration: BoxDecoration(
                                  color: appThemes.primaryColor(context),
                                  border: Border.all(
                                    color: appThemes.surfaceColor(context),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
