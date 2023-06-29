// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnnotationEntity {
 final String? annotationId;
 final String? annotationSaleTime;
 final String? annotationSaleDate;
 final String? annotationSaleValue;
 final String? annotationPaymentMethod;
 final String? annotationReminder;
 final String? annotationClientAddress;
 final bool? annotationConcluied;
 final bool? annotationWithPendency;
  
  AnnotationEntity({
   this.annotationId,
   required this.annotationSaleTime,
   required this.annotationSaleDate,
   required this.annotationSaleValue,
   required this.annotationPaymentMethod,
   required this.annotationReminder,
   required this.annotationClientAddress,
   required this.annotationConcluied,
   required this.annotationWithPendency,
  });
}
