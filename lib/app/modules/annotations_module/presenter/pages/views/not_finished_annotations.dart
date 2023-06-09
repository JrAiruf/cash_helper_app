import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/components/annotation_list_tile.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../../../../routes/app_routes.dart';

class NotFinishedAnnotations extends StatelessWidget {
  NotFinishedAnnotations(
      {super.key,
      required this.operatorEntity,
      required this.position,
      required this.annotations,
      required this.enterpriseId});
  OperatorEntity operatorEntity;
  List<AnnotationEntity> annotations;
  BottomNavigationBarPosition position;
  String enterpriseId;
  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return annotations.isEmpty
        ? Container(
            decoration: BoxDecoration(
              color: appTheme.backgroundColor(context),
            ),
            child: Center(
              child: Text(
                "Nenhuma Anotação Localizada",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          )
        : Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: appTheme.primaryColor(context),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: height * 0.05,
                  child: Center(
                    child: Text(
                      "Não Finalizadas",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: appTheme.surfaceColor(context),
                          ),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.7,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: appTheme.backgroundColor(context),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: ListView.builder(
                      itemCount: annotations.length,
                      itemBuilder: (_, i) {
                        final annotationAndOperatorObjects = {
                          "operatorEntity": operatorEntity,
                          "annotationEntity": annotations[i],
                        };
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnnotationListTile(
                            annotationEntity: annotations[i],
                            onTap: () {
                              Modular.to.pushNamed(
                                "${AnnotationRoutes.annotationPage}$enterpriseId",
                                arguments: annotationAndOperatorObjects,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
