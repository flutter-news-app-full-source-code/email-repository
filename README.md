<div align="center">
  <img src="https://avatars.githubusercontent.com/u/202675624?s=400&u=dc72a2b53e8158956a3b672f8e52e39394b6b610&v=4" alt="Flutter News App Toolkit Logo" width="220">
  <h1>Email Repository</h1>
  <p><strong>A repository that provides an abstraction layer over email operations for the Flutter News App Toolkit.</strong></p>
</div>

<p align="center">
  <img src="https://img.shields.io/badge/coverage-100%25-green?style=for-the-badge" alt="coverage">
  <a href="https://flutter-news-app-full-source-code.github.io/docs/"><img src="https://img.shields.io/badge/LIVE_DOCS-VIEW-slategray?style=for-the-badge" alt="Live Docs: View"></a>
  <a href="https://github.com/flutter-news-app-full-source-code"><img src="https://img.shields.io/badge/MAIN_PROJECT-BROWSE-purple?style=for-the-badge" alt="Main Project: Browse"></a>
</p>

This `email_repository` package contains the `EmailRepository` class, which acts as an abstraction layer over an `EmailClient` implementation (from the `email_client` package) within the [**Flutter News App Full Source Code Toolkit**](https://github.com/flutter-news-app-full-source-code). Its primary purpose is to provide a clean, business-focused interface for email-related tasks while ensuring consistent error handling. The repository translates business-specific requests (e.g., "send an OTP") into generic, template-based calls to the underlying `EmailClient`, effectively decoupling the application's core logic from the specifics of email formatting and delivery.

## ⭐ Feature Showcase: Business-Focused Email Management

This package offers a comprehensive set of features for managing email operations.

<details>
<summary><strong>🧱 Core Functionality</strong></summary>

### 🚀 `EmailRepository` Class
- **`EmailRepository`:** Provides a clean, business-focused interface for email-related tasks, abstracting the underlying `EmailClient` implementation.
- **`sendOtpEmail` Method:** Offers a dedicated method for sending One-Time Password (OTP) emails, abstracting the details of template ID and data construction.

### 🌐 Decoupled Email Logic
- **Abstraction over `EmailClient`:** Decouples the application's core logic from the specifics of email formatting and delivery by translating business requests into generic, template-based calls to the `EmailClient`.

### 🛡️ Standardized Error Handling
- **`HttpException` Propagation:** Catches and re-throws `HttpException` subtypes (from `core`) propagated from the underlying `EmailClient`, ensuring consistent and predictable error management across the application layers.

### 💉 Dependency Injection Ready
- **`EmailClient` Dependency:** Requires an instance of `EmailClient` (from the `email_client` package) via its constructor, promoting loose coupling and testability.

> **💡 Your Advantage:** This package provides a business-focused abstraction for email operations, simplifying the integration of email sending into your application logic. It ensures consistent error handling and decouples your core application from the specifics of email service providers, enhancing maintainability and flexibility.

</details>

## 🔑 Licensing

This `email_repository` package is an integral part of the [**Flutter News App Full Source Code Toolkit**](https://github.com/flutter-news-app-full-source-code). For comprehensive details regarding licensing, including trial and commercial options for the entire toolkit, please refer to the main toolkit organization page.
