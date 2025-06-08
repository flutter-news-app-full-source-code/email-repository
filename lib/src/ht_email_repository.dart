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

  /// Sends a One-Time Password (OTP) email via the email client.
  ///
  /// Delegates the call to the injected [HtEmailClient].
  ///
  /// Throws [HtHttpException] subtypes on failure, as propagated
  /// from the client.
  Future<void> sendOtpEmail({
    required String recipientEmail,
    required String otpCode,
  }) async {
    try {
      await _emailClient.sendOtpEmail(
        recipientEmail: recipientEmail,
        otpCode: otpCode,
      );
    } on HtHttpException {
      rethrow; // Propagate client-level exceptions
    }
    // Catch-all for unexpected errors is generally avoided here,
    // relying on the client's defined exceptions.
  }
}
