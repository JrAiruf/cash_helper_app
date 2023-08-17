// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';

class PendencyAdapter {
  String? pendencyId;
  String? pendencySaleTime;
  String? pendencySaleDate;
  String? annotationId;
  bool? pendencyFinished;
  String? pendencyPeriod;
  String? operatorId;
  PendencyAdapter({
    this.pendencyId,
    this.pendencySaleTime,
    this.pendencySaleDate,
    this.annotationId,
    this.pendencyFinished,
    this.pendencyPeriod,
    this.operatorId,
  });
  static PendencyEntity fromMap(Map data) {
    return PendencyEntity(
      pendencyId: data["pendencyId"],
      annotationId: data["annotationId"],
      pendencySaleTime: data["pendencySaleTime"],
      pendencySaleDate: data["pendencySaleDate"],
      pendencyFinished: data["pendencyFinished"],
      pendencyPeriod: data["pendencyPeriod"],
      operatorId: data["operatorId"],
    );
  }

  static Map<String, dynamic> fromEntity(PendencyEntity pendency) {
    return {
      "pendencyId": pendency.pendencyId,
      "annotationId": pendency.annotationId,
      "pendencySaleTime": pendency.pendencySaleTime,
      "pendencySaleDate": pendency.pendencySaleDate,
      "pendencyFinished": pendency.pendencyFinished,
      "pendencyPeriod": pendency.pendencyPeriod,
      "operatorId": pendency.operatorId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "pendencyId": pendencyId,
      "annotationId": annotationId,
      "pendencySaleTime": pendencySaleTime,
      "pendencySaleDate": pendencySaleDate,
      "pendencyFinished": pendencyFinished,
      "pendencyPeriod": pendencyPeriod,
      "operatorId": operatorId,
    };
  }
}
