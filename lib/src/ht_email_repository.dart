import 'package:ht_email_client/ht_email_client.dart';
import 'package:ht_shared/ht_shared.dart'; // For HtHttpException

/// {@template ht_email_repository}
/// A repository that handles email sending operations.
///
/// This repository interacts with an underlying [HtEmailClient]
/// to send emails, such as One-Time Passwords (OTPs).
/// {@endtemplate}
class HtEmailRepository {
  /// {@macro ht_email_repository}
  ///
  /// Requires an instance of [HtEmailClient] to handle the actual
  /// email sending operations.
  const HtEmailRepository({required HtEmailClient emailClient})
    : _emailClient = emailClient;

  final HtEmailClient _emailClient;

  /// Sends a One-Time Password (OTP) email by calling the underlying client.
  ///
  /// This method abstracts the specific details of sending an OTP email. It
  /// constructs the required `templateData` and calls the generic
  /// `sendTransactionalEmail` method on the injected [HtEmailClient].
  ///
  /// - [senderEmail]: The email address of the sender.
  /// - [recipientEmail]: The email address of the recipient.
  /// - [otpCode]: The One-Time Password to be sent.
  /// - [templateId]: The ID of the transactional email template to use.
  ///
  /// Throws [HtHttpException] subtypes on failure, as propagated from the
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
    } on HtHttpException {
      rethrow; // Propagate client-level exceptions
    }
  }
}
