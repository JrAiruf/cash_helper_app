// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnnotationEntity {
 String? annotationId;
 String? annotationSaleTime;
 String? annotationSaleDate;
 String? annotationSaleValue;
 String? annotationPaymentMethod;
 String? annotationReminder;
 String? annotationClientAddress;
 bool? annotationConcluied;
 bool? annotationWithPendency;
  
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
