class OperatorEntity {
  String? operatorId;
  int? operatorNumber;
  String? operatorName;
  String? operatorEmail;
  String? operatorPassword;
  String? operatorOppening;
  String? operatorClosing;
  bool? operatorEnabled;
  OperatorOccupation? ocupation;

  OperatorEntity({
    this.operatorId,
    this.operatorNumber,
    this.operatorName,
    this.operatorEmail,
    this.operatorPassword,
    this.operatorOppening,
    this.operatorClosing,
    this.operatorEnabled,
    this.ocupation,
  });
}

enum OperatorOccupation {
  admin(occupation: "Admin"),
  cashierOperator(occupation: "Operator");

  final String occupation;
  const OperatorOccupation({required this.occupation});
}
