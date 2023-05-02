class ManagerEntity {
  final String managerId;
  final int managerNumber;
  final String managerName;
  final String managerEmail;
  final String managerPassword;
  final String managerCode;
  final String managerOppening;
  final String managerClosing;
  final bool managerEnabled;
  final String managerOcupation;

  ManagerEntity(
      {required this.managerId,
      required this.managerNumber,
      required this.managerName,
      required this.managerEmail,
      required this.managerPassword,
      required this.managerCode,
      required this.managerOppening,
      required this.managerClosing,
      required this.managerEnabled,
      required this.managerOcupation});
}
