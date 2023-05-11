import '../../../modules/annotations_module/domain/entities/annotation_entity.dart';
import '../../../modules/annotations_module/infra/models/annotation_model.dart';

class AnnotationsTestObjects {
  static final newAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: "No Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");

  static final newAnnotationModel = AnnotationModel(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: null,
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");

  static final repositoryAnnotation = AnnotationModel(
      annotationId: "askjdfhlakjsdhkajshdgkjahlskjdghla",
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: "No Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");

  static final modifiedAnnotationModel = AnnotationModel(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: true,
      annotationPaymentMethod: null,
      annotationReminder: "Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");

  static final newAnnotationMap = <String, dynamic>{
    'annotationId': "askjdfhlakjsdhkajshdgkjahlskjdghla",
    'annotationClientAddress': "Andorinhas 381",
    'annotationSaleValue': "125,56",
    'annotationSaleTime': "12:45",
    'annotationSaleDate': "07/04",
    'annotationPaymentMethod': "Dinheiro",
    'annotationReminder': null,
    'annotationConcluied': false,
  };
  static final updatedAnnotation = <String, dynamic>{
    'annotationClientAddress': "Andorinhas 381",
    'annotationSaleValue': "300",
    'annotationSaleTime': "12:45",
    'annotationSaleDate': "07/04",
    'annotationPaymentMethod': "Crédito",
    'annotationReminder': "Reminder added",
    'annotationConcluied': false,
  };
}
