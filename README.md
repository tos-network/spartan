# Sallet

Sallet is a multiplatform wallet for the TOS network. Built using the Flutter framework, it provides a convenient and secure way to manage your TOS cryptocurrency assets.

This wallet harnesses the power of Rust by incorporating a native Rust library from the TOS blockchain, ensuring the same level of security as the TOS Wallet CLI.

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

Follow the steps below to install and run Sallet on your desired platform.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Rust tool chain](https://www.rust-lang.org/tools/install)
- [Just command runner](https://just.systems/)

### Clone the Repository

```
git clone https://github.com/xelis-project/sallet.git
```

### Build and Run

1. Navigate to the cloned repository:

```
cd sallet
```

2. Install the required dependencies and generate glue code:

```
just init
```

3. Run the app for the current device:

```
flutter run --release
```

4. Or, build the application for your platform (e.g. ``windows``, etc.):

```
flutter build <platform>
```

For platform-specific instructions and additional configuration steps, please refer to the documentation available by following the links provided.

## License

Sallet is open source and licensed under the [GPL License](LICENSE). Feel free to modify and distribute the application as per the terms of the license.

## Contact

For any questions or inquiries, please contact the TOS team on [Discord](https://discord.gg/z543umPUdj).
