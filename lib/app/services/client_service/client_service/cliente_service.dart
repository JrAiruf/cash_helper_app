abstract class CLientService {
  Future<dynamic> get();
  Future<dynamic> post(String? url, Map? requestBody, Map? headers);
  Future<dynamic> put();
  Future<dynamic> delete();
}
