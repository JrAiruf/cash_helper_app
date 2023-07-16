// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnnotationEntity {
 String? annotationId;
 String? annotationCreatorId;
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
   this.annotationSaleTime,
   this.annotationCreatorId,
   this.annotationSaleDate,
   this.annotationSaleValue,
   this.annotationPaymentMethod,
   this.annotationReminder,
   this.annotationClientAddress,
   this.annotationConcluied,
   this.annotationWithPendency,
  });
}
