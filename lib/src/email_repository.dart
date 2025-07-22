import 'package:core/core.dart'; // For HttpException
import 'package:email_client/email_client.dart';

/// {@template email_repository}
/// A repository that handles email sending operations.
///
/// This repository interacts with an underlying [EmailClient]
/// to send emails, such as One-Time Passwords (OTPs).
/// {@endtemplate}
class EmailRepository {
  /// {@macro email_repository}
  ///
  /// Requires an instance of [EmailClient] to handle the actual
  /// email sending operations.
  const EmailRepository({required EmailClient emailClient})
    : _emailClient = emailClient;

  final EmailClient _emailClient;

  /// Sends a One-Time Password (OTP) email by calling the underlying client.
  ///
  /// This method abstracts the specific details of sending an OTP email. It
  /// constructs the required `templateData` and calls the generic
  /// `sendTransactionalEmail` method on the injected [EmailClient].
  ///
  /// - [senderEmail]: The email address of the sender.
  /// - [recipientEmail]: The email address of the recipient.
  /// - [otpCode]: The One-Time Password to be sent.
  /// - [templateId]: The ID of the transactional email template to use.
  ///
  /// Throws [HttpException] subtypes on failure, as propagated from the
  /// client.
  Future<void> sendOtpEmail({
    required String senderEmail,
    required String recipientEmail,
    required String otpCode,
    required String templateId,
  }) async {
    try {
      await _emailClient.sendTransactionalEmail(
        senderEmail: senderEmail,
        recipientEmail: recipientEmail,
        templateId: templateId,
        templateData: {'otp_code': otpCode},
      );
    } on HttpException {
      rethrow; // Propagate client-level exceptions
    }
  }
}
