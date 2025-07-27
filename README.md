

# Kacha Technical Exam Flutter App

## Project Description
The app is a Flutter-based mobile application designed for managing financial transactions, including wallet balance tracking, money transfers, currency exchange rate retrieval, and user authentication. The app follows a clean architecture pattern with Riverpod for state management, ensuring modularity, scalability, and maintainability. It supports features like user login/registration, viewing wallet balances and transaction history, sending money to other users, and fetching exchange rates. The app uses `SharedPreferences` for local data persistence and a network service (via Dio) for API interactions.

**Author**: Ermiyas

## Setup Instructions

### Prerequisites
- **Flutter SDK**: Version 3.22.x or later (run `flutter upgrade` to ensure the latest version).
- **Dart**: Version compatible with your Flutter SDK (typically bundled with Flutter).
- **Java**: Version 20.0.1 (required for Gradle compatibility).
- **IDE**: Android Studio, VS Code, or any IDE with Flutter support.
- **Dependencies**: Ensure you have Git and a package manager like `pub` installed.

### Installation Steps
1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-repo/kacha_test.git
   cd kacha_test
   ```

2. **Install Dependencies**
   Run the following to fetch all required packages:
   ```bash
   flutter pub get
   ```

3. **Set Up Java 20**
   - Verify your Java version:
     ```bash
     java -version
     ```
     Expected output: `java version "20.0.1"`.
   - If Java 20 is not installed, download it from [Adoptium](https://adoptium.net/) and set the `JAVA_HOME` environment variable:
     - On Windows:
       1. Set `JAVA_HOME` to `C:\Program Files\Java\jdk-20.0.1` (adjust path as needed).
       2. Add `%JAVA_HOME%\bin` to the `Path` variable.
       3. Restart your terminal or IDE.
   - Alternatively, specify Java 20 in `android/gradle.properties`:
     ```properties
     org.gradle.java.home=C:/Program Files/Java/jdk-20.0.1
     ```

4. **Configure Gradle**
   - Open `android/gradle/wrapper/gradle-wrapper.properties` and ensure:
     ```properties
     distributionUrl=https\://services.gradle.org/distributions/gradle-8.3-bin.zip
     ```
   - In `android/build.gradle`, set the Android Gradle Plugin:
     ```gradle
     buildscript {
         repositories {
             google()
             mavenCentral()
         }
         dependencies {
             classpath 'com.android.tools.build:gradle:8.1.4'
         }
     }
     ```
   - In `android/app/build.gradle`, ensure:
     ```gradle
     android {
         compileSdkVersion 34
         defaultConfig {
             minSdkVersion 21
             targetSdkVersion 34
         }
     }
     ```

5. **Clear Caches (if needed)**
   - Clear Gradle cache:
     ```bash
     rmdir /s C:\Users\YourUsername\.gradle\caches
     ```
   - Clear Flutter build cache:
     ```bash
     flutter clean
     ```

6. **Run the App**
   - Start an emulator or connect a device.
   - Run the app:
     ```bash
     flutter run
     ```
   - Or build an APK:
     ```bash
     flutter build apk
     ```

7. **Dependencies**
   Ensure the following are in `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     flutter_riverpod: ^2.5.1
     go_router: ^14.2.0
     dartz: ^0.10.1
     shared_preferences: ^2.2.3
     dio: ^5.7.0
   ```

### Architecture Description
Kacha follows a **clean architecture** approach, separating concerns into layers for better maintainability and testability. The architecture is structured as follows:

- **Presentation Layer**:
  - Contains UI components (screens and widgets) like `LoginScreen`, `DashboardScreen`, `SendMoneyScreen`, and `ExchangeScreen`.
  - Uses `flutter_riverpod` for state management to manage UI state and interact with the domain layer.
  - Navigation is handled by `go_router`, defining routes for login, dashboard, send money, and exchange features.

- **Domain Layer**:
  - Defines core business logic and entities (`User`, `Wallet`, `Transaction`, `ExchangeRate`).
  - Includes repository interfaces (`AuthRepository`, `WalletRepository`, `TransferRepository`, `ExchangeRepository`) that abstract data operations.
  - Uses `dartz` for functional error handling with `Either<AppException, T>`.

- **Data Layer**:
  - Implements repositories using data sources:
    - **Remote Data Sources**: `AuthRemoteDataSource`, `WalletRemoteDataSource`, `TransferRemoteDataSource`, `ExchangeRemoteDataSource` interact with APIs via `DioNetworkService`.
    - **Local Data Source**: `WalletLocalDataSource` uses `SharedPreferences` for caching wallet balances and transactions.
  - Models (`User`, `Wallet`, `Transaction`, `ExchangeRate`) are plain Dart classes with JSON serialization (`toJson`/`fromJson`).

- **Dependency Injection**:
  - Uses `flutter_riverpod` for dependency injection (e.g., `networkServiceProvider`, `sharedPrefProvider`, `walletLocalDataSourceProvider`).
  - Previously used `get_it` for some dependencies, now fully transitioned to Riverpod for consistency.

- **Data Flow**:
  - API calls fetch data (e.g., wallet balance, transactions, exchange rates) via remote data sources.
  - Data is cached locally using `SharedPreferences` for offline access.
  - Repositories combine remote and local data sources, prioritizing remote data and falling back to cache on failure.
  - UI updates are triggered via Riverpod providers, ensuring reactive state management.

### Key Features
- **Authentication**: Login and registration with email, password, and name, returning a `User` and token.
- **Wallet Management**: Fetch and cache wallet balance and transaction history.
- **Money Transfer**: Send money to other users with recipient ID, amount, currency, and optional note.
- **Exchange Rates**: Retrieve exchange rates for currency pairs, with mock data support for testing.
- **Navigation**: Seamless routing between screens using `go_router`.

### Troubleshooting
- **Gradle Errors**:
  - If you see "Unsupported class file major version 65", ensure Java 20 is used (`java -version` should show 20.0.1) and Gradle is set to 8.3.
  - Clear Gradle cache: `rmdir /s C:\Users\YourUsername\.gradle\caches`.
- **Dependency Issues**: Run `flutter pub upgrade` to ensure compatible package versions.
- **Build Failures**: Run `flutter run --debug --stacktrace` or `cd android && gradlew build --stacktrace` for detailed logs.

### Contributing
Contributions are welcome! Please fork the repository, create a feature branch, and submit a pull request with clear descriptions of changes.

### License
This project is licensed under the MIT License.

**Author**: Ermiyas Solomon

