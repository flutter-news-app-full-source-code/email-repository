// test/src/ht_email_repository_test.dart
import 'package:ht_email_client/ht_email_client.dart';
import 'package:ht_email_repository/ht_email_repository.dart';
import 'package:ht_shared/ht_shared.dart'; // For HtHttpException and subtypes
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mock for the HtEmailClient dependency
class MockHtEmailClient extends Mock implements HtEmailClient {}

void main() {
  group('HtEmailRepository', () {
    late HtEmailClient mockEmailClient;
    late HtEmailRepository emailRepository;

    const testEmail = 'test@example.com';
    const testOtpCode = '123456';

    setUp(() {
      mockEmailClient = MockHtEmailClient();
      emailRepository = HtEmailRepository(emailClient: mockEmailClient);

      // Register fallback values for any() matchers if needed,
      // especially for parameters with default values or complex types.
      // Example: registerFallbackValue(Uri.parse('http://example.com'));
    });

    // Teardown can be used to reset mocks after each test if necessary
    // tearDown(() {
    //   reset(mockEmailClient);
    // });

    test('can be instantiated', () {
      expect(HtEmailRepository(emailClient: MockHtEmailClient()), isNotNull);
    });

    group('sendOtpEmail', () {
      test('calls sendOtpEmail on client successfully', () async {
        // Arrange
        when(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: any(named: 'recipientEmail'),
            otpCode: any(named: 'otpCode'),
          ),
        ).thenAnswer((_) async {}); // Simulate successful void return

        // Act
        await emailRepository.sendOtpEmail(
          recipientEmail: testEmail,
          otpCode: testOtpCode,
        );

        // Assert
        verify(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
        ).called(1);
        // Verify no other methods were called on the mock
        verifyNoMoreInteractions(mockEmailClient);
      });

      test('propagates NetworkException from client', () async {
        // Arrange
        const exception = NetworkException();
        when(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: any(named: 'recipientEmail'),
            otpCode: any(named: 'otpCode'),
          ),
        ).thenThrow(exception); // Simulate client throwing the exception

        // Act & Assert
        expect(
          () => emailRepository.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
          throwsA(exception), // Expect the exact exception to be propagated
        );

        // Verify the client method was called
        verify(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailClient);
      });

      test('propagates InvalidInputException from client', () async {
        // Arrange
        const exception = InvalidInputException('Invalid email format');
        when(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: any(named: 'recipientEmail'),
            otpCode: any(named: 'otpCode'),
          ),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => emailRepository.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
          throwsA(exception),
        );

        // Verify
        verify(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailClient);
      });

      test('propagates ServerException from client', () async {
        // Arrange
        const exception = ServerException('Email service unavailable');
        when(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: any(named: 'recipientEmail'),
            otpCode: any(named: 'otpCode'),
          ),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => emailRepository.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
          throwsA(exception),
        );

        // Verify
        verify(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailClient);
      });

      test('propagates OperationFailedException from client', () async {
        // Arrange
        const exception = OperationFailedException('Unknown sending error');
        when(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: any(named: 'recipientEmail'),
            otpCode: any(named: 'otpCode'),
          ),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => emailRepository.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
          throwsA(exception),
        );

        // Verify
        verify(
          () => mockEmailClient.sendOtpEmail(
            recipientEmail: testEmail,
            otpCode: testOtpCode,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailClient);
      });
    }); // End group 'sendOtpEmail'
  }); // End group 'HtEmailRepository'
} // End main
