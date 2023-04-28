abstract class ILogin {
  Future<dynamic> call(String? email, String? password, String? collection);
}
