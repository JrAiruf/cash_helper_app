part of 'check_user_data_bloc.dart';

@immutable
abstract class CheckUserDataEvents {}

class CheckUserDataEvent implements CheckUserDataEvents {
  final String enterpriseId;
  final String userEmail;
  final String userCode;
  final String businessPosition;

  CheckUserDataEvent(
    this.enterpriseId,
    this.userEmail,
    this.userCode,
    this.businessPosition,
  );
}
