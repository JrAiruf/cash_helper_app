abstract class ApplicationEnterpriseDatabase {
  Future<dynamic> createEnterpriseAccount(Map<String, dynamic> enterpriseMap);
  Future<dynamic> getEnterpriseByCode(String enterpriseCode);
}
