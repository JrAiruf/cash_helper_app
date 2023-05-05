import 'dart:convert';

import '../../domain/entities/annotation_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnnotationModel {
  String? annotationId;
  String? annotationClientAddress;
  String? annotationSaleValue;
  String? annotationSaleTime;
  String? annotationSaleDate;
  String? annotationPaymentMethod;
  String? annotationReminder;
  bool? annotationConcluied;

  AnnotationModel({
    this.annotationId,
    this.annotationClientAddress,
    this.annotationSaleValue,
    this.annotationSaleTime,
    this.annotationSaleDate,
    this.annotationPaymentMethod,
    this.annotationReminder,
    this.annotationConcluied,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'annotationId': annotationId,
      'annotationClientAddress': annotationClientAddress,
      'annotationSaleValue': annotationSaleValue,
      'annotationSaleTime': annotationSaleTime,
      'annotationSaleDate': annotationSaleDate,
      'annotationPaymentMethod': annotationPaymentMethod,
      'annotationReminder': annotationReminder,
      'annotationConcluied': annotationConcluied,
    };
  }

  factory AnnotationModel.fromMap(Map<String, dynamic> map) {
    return AnnotationModel(
      annotationId: map['annotationId'],
      annotationClientAddress: map['annotationClientAddress'],
      annotationSaleValue: map['annotationSaleValue'],
      annotationSaleTime: map['annotationSaleTime'],
      annotationSaleDate: map['annotationSaleDate'],
      annotationPaymentMethod: map['annotationPaymentMethod'],
      annotationReminder: map['annotationReminder'],
      annotationConcluied: map['annotationConcluied'],
    );
  }
  static AnnotationEntity toEntityData(AnnotationModel annotationModel) {
    return AnnotationEntity(
      annotationId: annotationModel.annotationId,
      annotationClientAddress: annotationModel.annotationClientAddress,
      annotationSaleValue: annotationModel.annotationSaleValue,
      annotationSaleTime: annotationModel.annotationSaleTime,
      annotationSaleDate: annotationModel.annotationSaleDate,
      annotationPaymentMethod: annotationModel.annotationPaymentMethod,
      annotationReminder: annotationModel.annotationReminder,
      annotationConcluied: annotationModel.annotationConcluied,
    );
  }

  static AnnotationModel fromEntityData(AnnotationEntity annotationEntity) {
    return AnnotationModel(
      annotationId: annotationEntity.annotationId,
      annotationClientAddress: annotationEntity.annotationClientAddress,
      annotationSaleValue: annotationEntity.annotationSaleValue,
      annotationSaleTime: annotationEntity.annotationSaleTime,
      annotationSaleDate: annotationEntity.annotationSaleDate,
      annotationPaymentMethod: annotationEntity.annotationPaymentMethod,
      annotationReminder: annotationEntity.annotationReminder,
      annotationConcluied: annotationEntity.annotationConcluied,
    );
  }

  static AnnotationEntity copyWith(AnnotationEntity annotationEntity) {
    return AnnotationEntity(
        annotationSaleTime: annotationEntity.annotationSaleTime,
        annotationSaleDate: annotationEntity.annotationSaleDate,
        annotationSaleValue: annotationEntity.annotationSaleValue,
        annotationPaymentMethod: annotationEntity.annotationPaymentMethod,
        annotationReminder: annotationEntity.annotationReminder,
        annotationClientAddress: annotationEntity.annotationClientAddress,
        annotationConcluied: annotationEntity.annotationConcluied);
  }

  String toJson() => json.encode(toMap());

  factory AnnotationModel.fromJson(String source) =>
      AnnotationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
