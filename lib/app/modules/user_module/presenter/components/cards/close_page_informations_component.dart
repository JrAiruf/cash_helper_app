import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';

class ClosePageInformationsComponent extends StatelessWidget {
  const ClosePageInformationsComponent({required this.annotations, super.key});

  final List<AnnotationEntity> annotations;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    final finishedAnnotations = annotations.where((element) => element.annotationConcluied == true).toList();
    final pendingAnnotations = annotations.where((element) => element.annotationConcluied == false).toList();
    return SizedBox(
      height: sizeFrame ? height * 0.24 : height * 0.26,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: height * 0.065,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 0.5,
                color: appThemes.surfaceColor(context),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Finalizadas:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: appThemes.surfaceColor(context),
                          ),
                    ),
                    CircleAvatar(
                      backgroundColor: appThemes.purpleColor(context),
                      radius: 20,
                      child: Text(
                        "${finishedAnnotations.length}",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: appThemes.surface(context),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.065,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 0.5,
                color: appThemes.surfaceColor(context),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pendentes:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: appThemes.surfaceColor(context),
                          ),
                    ),
                    CircleAvatar(
                      backgroundColor: appThemes.purpleColor(context),
                      radius: 20,
                      child: Text(
                        "${pendingAnnotations.length}",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: appThemes.surface(context),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.065,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 0.5,
                color: appThemes.surfaceColor(context),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: appThemes.surfaceColor(context),
                          ),
                    ),
                    CircleAvatar(
                      backgroundColor: appThemes.purpleColor(context),
                      radius: 20,
                      child: Text(
                        "${annotations.length}",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: appThemes.surface(context),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
