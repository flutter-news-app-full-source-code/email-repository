// test/src/email_repository_test.dart
import 'package:core/core.dart';
import 'package:email_client/email_client.dart';
import 'package:email_repository/email_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mock for the EmailClient dependency
class MockEmailClient extends Mock implements EmailClient {}

void main() {
  group('EmailRepository', () {
    late EmailClient mockEmailClient;
    late EmailRepository emailRepository;

    const testSenderEmail = 'sender@example.com';
    const testEmail = 'test@example.com';
    const testOtpCode = '123456';
    const testTemplateId = 'd-otp-template';

    setUp(() {
      mockEmailClient = MockEmailClient();
      emailRepository = EmailRepository(emailClient: mockEmailClient);
    });

    test('can be instantiated', () {
      expect(EmailRepository(emailClient: MockEmailClient()), isNotNull);
    });

    group('sendOtpEmail', () {
      test(
        'calls sendTransactionalEmail on client with correct data successfully',
        () async {
          // Arrange
          when(
            () => mockEmailClient.sendTransactionalEmail(
              senderEmail: any(named: 'senderEmail'),
              recipientEmail: any(named: 'recipientEmail'),
              templateId: any(named: 'templateId'),
              templateData: any(named: 'templateData'),
            ),
          ).thenAnswer((_) async {}); // Simulate successful void return

          // Act
          await emailRepository.sendOtpEmail(
            senderEmail: testSenderEmail,
            recipientEmail: testEmail,
            otpCode: testOtpCode,
            templateId: testTemplateId,
          );

          // Assert
          verify(
            () => mockEmailClient.sendTransactionalEmail(
              senderEmail: testSenderEmail,
              recipientEmail: testEmail,
              templateId: testTemplateId,
              templateData: {'otp_code': testOtpCode},
            ),
          ).called(1);
          verifyNoMoreInteractions(mockEmailClient);
        },
      );

      test('propagates HttpException from client', () async {
        // Arrange
        const exception = NetworkException();
        when(
          () => mockEmailClient.sendTransactionalEmail(
            senderEmail: any(named: 'senderEmail'),
            recipientEmail: any(named: 'recipientEmail'),
            templateId: any(named: 'templateId'),
            templateData: any(named: 'templateData'),
          ),
        ).thenThrow(exception); // Simulate client throwing the exception

        // Act & Assert
        expect(
          () => emailRepository.sendOtpEmail(
            senderEmail: testSenderEmail,
            recipientEmail: testEmail,
            otpCode: testOtpCode,
            templateId: testTemplateId,
          ),
          throwsA(isA<HttpException>()),
        );

        // Verify the client method was called
        verify(
          () => mockEmailClient.sendTransactionalEmail(
            senderEmail: testSenderEmail,
            recipientEmail: testEmail,
            templateId: testTemplateId,
            templateData: {'otp_code': testOtpCode},
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailClient);
      });
    });
  });
}
