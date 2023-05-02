abstract class CLientService {
  Future<dynamic> get();
  Future<dynamic> post({String? url, Map<String,dynamic>? requestBody, String? statusMessage,Map<String,dynamic>? headers});
  Future<dynamic> put();
  Future<dynamic> delete();
}
