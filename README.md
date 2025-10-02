# Spartan

Spartan is a multiplatform wallet for the TOS network. Built using the Flutter framework, it provides a convenient and secure way to manage your TOS cryptocurrency assets.

This wallet harnesses the power of Rust by incorporating a native Rust library from the TOS blockchain, ensuring the same level of security as the TOS Wallet CLI.

## Name and Icon

The name "Spartan" refers to the legendary warriors of ancient Sparta, renowned for their discipline, courage, and unwavering commitment to protection. Just as Spartan warriors were known for their formidable defense, the Spartan wallet is designed to safeguard your digital assets with the highest security standards.

Our app icon features a classic Spartan warrior helmet emblem with:
- **Shield badge**: Golden shield-shaped border representing impenetrable protection
- **Profile helmet**: Side-view Spartan helmet in gold, showcasing the iconic face guard and cheek plates
- **Red horsehair crest**: Distinctive mohawk-style plume flowing from the helmet crown, a symbol of warrior status
- **Vintage aesthetic**: Textured, weathered appearance evoking ancient strength and battle-tested reliability
- **Dark background**: Deep black backdrop that makes the golden warrior stand out with authority

This timeless design embodies our mission: to guard your crypto assets with the same unwavering vigilance and indomitable spirit that defined the ancient Spartan warriors.

## Features

- Securely store and manage your TOS tokens
- View your account balance and transaction history
- Send and receive TOS tokens easily
- Support for multiple platforms, including:
  - iOS
  - Android
  - Windows
  - macOS
  - Linux

## Installation

Follow the steps below to install and run Spartan on your desired platform.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Rust tool chain](https://www.rust-lang.org/tools/install)
- [Just command runner](https://just.systems/)

### Clone the Repository

```
git clone https://github.com/tos-project/spartan.git
```

### Build and Run

1. Navigate to the cloned repository:

```
cd spartan
```

2. Install the required dependencies and generate glue code:

```
just init
```

3. Run the app for the current device:

```
flutter run --release
```

4. Or, build the application for your platform:

#### Platform-Specific Build Commands

- **Android** (requires Android SDK):
  ```bash
  flutter build apk
  ```

- **iOS** (requires macOS and Xcode):
  ```bash
  flutter build ios
  ```

- **macOS** (requires macOS):
  ```bash
  flutter build macos
  ```

- **Windows** (requires Windows):
  ```bash
  flutter build windows
  ```

- **Linux** (requires Linux):
  ```bash
  flutter build linux
  ```

- **Web**:
  ```bash
  flutter build web
  ```

For platform-specific instructions and additional configuration steps, please refer to the documentation available by following the links provided.

## License

Spartan is open source and licensed under the [GPL License](LICENSE). Feel free to modify and distribute the application as per the terms of the license.
