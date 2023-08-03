import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/get_recent_activities_bloc/get_recent_activities_bloc.dart';

class RecentActivitiesComponent extends StatelessWidget {
  const RecentActivitiesComponent({super.key, required this.controller});

  final ManagementController controller;
  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    return BlocBuilder<GetRecentActivitiesBloc, GetRecentActivitiesStates>(
      bloc: controller.getRecentActivitiesBloc,
      builder: (__, state) {
        if (state is GetRecentActivitiesLoadingState) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LinearProgressIndicator(
                minHeight: 1,
                color: appThemes.blueColor(context),
              ),
            ),
          );
        }
        if (state is NoRecentActivitiesState) {
          return Center(
            child: Text(
              "Nenhuma Atividade Recente",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
          );
        }
        if (state is GetRecentActivitiesSuccessState) {
          return ListView.builder(
              itemCount: state.operators.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                final operator = state.operators[i];
                final operatorAnnotations = state.annotations.where((annotation) => annotation.annotationCreatorId == operator.operatorId);
                final operatorPendencies = state.pendencies.where((pendency) => pendency.operatorId == operator.operatorId);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(operator.operatorName ?? ""),
                      Text(operatorAnnotations.isNotEmpty ? "Anotações: ${operatorAnnotations.length}" : "Sem anotações"),
                      Text(operatorPendencies.isNotEmpty ? "Pendências: ${operatorPendencies.length}" : "Sem pendências"),
                      Text(operator.operatorClosing ?? ""),
                    ],
                  ),
                );
              });
        }
        return Container();
      },
    );
  }
}
