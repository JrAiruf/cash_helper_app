import 'package:bcrypt/bcrypt.dart';
import 'package:cash_helper_app/app/services/crypt_serivce.dart';

class EncryptService implements ICryptService {
  @override
  bool checkHashCode(String source, String hashCode) {
    return BCrypt.checkpw(source, hashCode);
  }

  @override
  String generateHash(String source) {
    final hashedSource = BCrypt.hashpw(source, BCrypt.gensalt());
    return hashedSource;
  }
}
