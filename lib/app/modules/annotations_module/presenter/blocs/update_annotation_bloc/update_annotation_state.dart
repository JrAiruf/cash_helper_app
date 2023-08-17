part of 'update_annotation_bloc.dart';

@immutable
abstract class UpdateAnnotationStates {}

class UpdateAnnotationInitialState extends UpdateAnnotationStates {}
class UpdateAnnotationLoadingState extends UpdateAnnotationStates {}
class UpdateAnnotationFailureState extends UpdateAnnotationStates {}
class UpdateAnnotationSuccessState extends UpdateAnnotationStates {}
