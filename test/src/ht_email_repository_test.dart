// test/src/ht_email_repository_test.dart
import 'package:ht_email_client/ht_email_client.dart';
import 'package:ht_email_repository/ht_email_repository.dart';
import 'package:ht_shared/ht_shared.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mock for the HtEmailClient dependency
class MockHtEmailClient extends Mock implements HtEmailClient {}

void main() {
  group('HtEmailRepository', () {
    late HtEmailClient mockEmailClient;
    late HtEmailRepository emailRepository;

    const testSenderEmail = 'sender@example.com';
    const testEmail = 'test@example.com';
    const testOtpCode = '123456';
    const testTemplateId = 'd-otp-template';

    setUp(() {
      mockEmailClient = MockHtEmailClient();
      emailRepository = HtEmailRepository(emailClient: mockEmailClient);
    });

    test('can be instantiated', () {
      expect(HtEmailRepository(emailClient: MockHtEmailClient()), isNotNull);
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

      test('propagates HtHttpException from client', () async {
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
          throwsA(isA<HtHttpException>()),
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
