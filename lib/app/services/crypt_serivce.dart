abstract class ICryptService {
  String generateHash(String source);
  bool checkHashCode(String source, String hashCode);
}
