# email_repository

![coverage: percentage](https://img.shields.io/badge/coverage-100-green)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![License: PolyForm Free Trial](https://img.shields.io/badge/License-PolyForm%20Free%20Trial-blue)](https://polyformproject.org/licenses/free-trial/1.0.0)

A repository that provides an abstraction layer over email operations.

## Description

This package contains the `EmailRepository`, which acts as an abstraction
layer over an `EmailClient` implementation (from the `email_client`
package). Its primary purpose is to provide a clean, business-focused interface
for email-related tasks while ensuring consistent error handling.

The repository translates business-specific requests (e.g., "send an OTP")
into generic, template-based calls to the underlying `EmailClient`,
decoupling the application's core logic from the specifics of email
formatting and delivery.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  email_repository:
    git:
      url: https://github.com/flutter-news-app-full-source-code/email-repository.git
      # ref: <specific_tag_or_commit> # Optional: Pin to a specific version
```

Then, import the library:

```dart
import 'package:email_repository/email_repository.dart';
```

## Features

*   Provides the `EmailRepository` class.
*   Offers a `sendOtpEmail` method that abstracts the process of sending an
    OTP. It calls the underlying client's `sendTransactionalEmail` method,
    passing the required template ID and data.

## Usage

To use this repository, you need to provide an instance of a concrete
`EmailClient` implementation during instantiation. The consumer of the
repository is responsible for providing the template ID.

```dart
// Example (in a service that has access to config)
final emailRepository = EmailRepository(emailClient: myEmailClient);
const otpTemplateId = 'd-123456789'; // This would come from config

// Now you can use the repository methods
try {
  await emailRepository.sendOtpEmail(
    senderEmail: 'noreply@yourdomain.com',
    recipientEmail: 'user@example.com',
    otpCode: '123456',
    templateId: otpTemplateId,
  );
  print('OTP email sent successfully!');
} on HttpException catch (e) {
  print('Failed to send OTP email: $e');
}
```

*(Note: The specific `EmailClient` implementation will depend on your project's setup, e.g., using a real email service client or an in-memory version for testing.)*




## 🔑 Licensing

This package is source-available and licensed under the [PolyForm Free Trial 1.0.0](LICENSE). Please review the terms before use.

For commercial licensing options that grant the right to build and distribute unlimited applications, please visit the main [**Flutter News App - Full Source Code Toolkit**](https://github.com/flutter-news-app-full-source-code) organization.
