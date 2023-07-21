abstract class GetEnterpriseByCodeEvents {}

class GetEnterpriseByCodeEvent implements GetEnterpriseByCodeEvents {
  final String enterpriseCode;

  GetEnterpriseByCodeEvent(this.enterpriseCode);
}

class InitialAppEvent implements GetEnterpriseByCodeEvents {}
