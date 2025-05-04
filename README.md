# ht_email_repository

![coverage: percentage](https://img.shields.io/badge/coverage-XX-green)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![License: PolyForm Free Trial](https://img.shields.io/badge/License-PolyForm%20Free%20Trial-blue)](https://polyformproject.org/licenses/free-trial/1.0.0)

A Dart package providing a repository layer for email operations within the
Headlines Toolkit ecosystem.

## Description

This package contains the `HtEmailRepository`, which acts as an abstraction
layer over an `HtEmailClient` implementation (from the `ht_email_client`
package). Its primary purpose is to provide a clean interface for email-related
tasks while ensuring consistent error handling according to the project's
standards (propagating `HtHttpException` subtypes from `ht_shared`).

Currently, it focuses on sending One-Time Password (OTP) emails.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  ht_email_repository:
    git:
      url: https://github.com/headlines-toolkit/ht-email-repository.git
      # ref: <specific_tag_or_commit> # Optional: Pin to a specific version
```

Then, import the library:

```dart
import 'package:ht_email_repository/ht_email_repository.dart';
```

## Features

*   Provides the `HtEmailRepository` class.
*   Offers a `sendOtpEmail` method to facilitate sending OTPs via an injected
    `HtEmailClient`.

## Usage

To use this repository, you need to provide an instance of a concrete
`HtEmailClient` implementation during instantiation.

```dart
// Example (assuming you have an HtEmailClient instance named 'myEmailClient')
final emailRepository = HtEmailRepository(emailClient: myEmailClient);

// Now you can use the repository methods
try {
  await emailRepository.sendOtpEmail(
    recipientEmail: 'user@example.com',
    otpCode: '123456',****
  );
  print('OTP email sent successfully!');
} on HtHttpException catch (e) {
  print('Failed to send OTP email: $e');
}
```

*(Note: The specific `HtEmailClient` implementation will depend on your project's setup, e.g., using a real email service client or an in-memory version for testing.)*

## License

This package is licensed under the [PolyForm Free Trial](LICENSE). Please review the terms before use.
