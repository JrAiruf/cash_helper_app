abstract class SendEmailService {
  Future<dynamic> sendEmail(String to, String subject, String content);
}
