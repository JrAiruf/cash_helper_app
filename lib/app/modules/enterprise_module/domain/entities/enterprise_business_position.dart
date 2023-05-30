enum EnterpriseBusinessPosition {
  cashOperator(position: "operator"),
  manager(position:"manager");

  final String position;
  const EnterpriseBusinessPosition({required this.position});
}
