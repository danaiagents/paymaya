# PayMaya Application - Technical Documentation

## 1. Overview

This document provides a technical overview of the PayMaya Flutter application. It is intended for developers to understand the project structure, architecture, and implementation details.

## 2. Project Structure

The project follows a feature-driven directory structure, which is a common practice in large-scale Flutter applications. This approach helps in separating the code for each feature into its own module, making it easier to maintain and scale the application.

```
lib/
├── core/
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── utils/
│       ├── app_strings.dart
│       └── logger.dart
├── features/
│   └── wallet/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── cubit/
│           └── screens/
├── injection_container.dart
└── main.dart
```

- **`core`**: This directory contains the shared code that can be used across multiple features.
  - **`error`**: Defines custom exception and failure classes for consistent error handling.
  - **`usecases`**: Contains the base `UseCase` class.
  - **`utils`**: Utility classes and constants, such as `AppStrings` for localization and `Logger` for logging.
- **`features`**: Each feature of the application is a separate module inside this directory.
  - **`wallet`**: The main feature of the application, containing all the code related to the digital wallet.
    - **`data`**: Implementation of the data layer, including data sources, models, and repositories.
    - **`domain`**: The business logic of the feature, including entities, repository contracts, and use cases.
    - **`presentation`**: The UI layer, containing screens, widgets, and state management (Cubit).
- **`injection_container.dart`**: Initializes and configures the dependency injection using the `get_it` package.
- **`main.dart`**: The entry point of the application.

## 3. Architecture

The application is built using the **Clean Architecture** principles, which separate the code into three main layers:

- **Domain Layer**: This is the core of the application. It contains the business logic, entities, and use cases. It is independent of any other layer.
- **Data Layer**: This layer is responsible for fetching data from various sources (e.g., API, database). It implements the repository contracts defined in the domain layer.
- **Presentation Layer**: This is the UI layer of the application. It is responsible for displaying the data to the user and handling user interactions. It uses the **BLoC (Business Logic Component)** pattern for state management.

This separation of concerns makes the application more modular, scalable, and testable.

## 4. State Management

The application uses the `flutter_bloc` package for state management. The `WalletCubit` in `lib/features/wallet/presentation/cubit/` manages the state of the wallet feature. It exposes a stream of `WalletState` objects, which the UI listens to and rebuilds accordingly.

## 5. Dependency Injection

Dependency injection is handled by the `get_it` package. The `injection_container.dart` file is responsible for registering all the dependencies, such as data sources, repositories, use cases, and cubits. This makes it easy to provide mock dependencies during testing.

## 6. Core Components

### Error Handling

The `core/error` directory contains a structured approach to error handling.
- **`Exceptions`**: Thrown by the data layer when an error occurs (e.g., `ServerException`).
- **`Failures`**: Represent user-friendly error messages that can be displayed on the UI. The repository layer catches exceptions and converts them into failures (e.g., `ServerFailure`).

### Use Cases

Use cases represent the business logic of the application. Each use case has a single responsibility and is executed by the presentation layer. The base `UseCase` class in `core/usecases/usecase.dart` defines the contract for all use cases.

## 7. Wallet Feature

The `wallet` feature is the main feature of the application.

### Data Layer

- **`models`**: `WalletModel` and `TransactionModel` are the data transfer objects (DTOs) that represent the data fetched from the API. They extend the domain entities and include methods for JSON serialization/deserialization.
- **`datasources`**: `WalletRemoteDataSource` is an abstract class that defines the contract for fetching wallet data. `WalletRemoteDataSourceImpl` is the implementation that uses the `http` package to make API calls. `WalletRemoteDataSourceMock` provides mock data for testing and development.
- **`repositories`**: `WalletRepositoryImpl` implements the `WalletRepository` contract from the domain layer. It communicates with the data source and handles error conversion from exceptions to failures.

### Domain Layer

- **`entities`**: `Wallet` and `Transaction` are the plain Dart objects that represent the core business objects.
- **`repositories`**: `WalletRepository` is an abstract class that. It communicates with the data source and handles error conversion from exceptions to failures.

### Domain Layer

- **`entities`**: `Wallet` and `Transaction` are the plain Dart objects that represent the core business objects.
- **`repositories`**: `WalletRepository` is an abstract class that defines the contract for the wallet feature's data operations.
- **`usecases`**: `GetWallet`, `GetTransactions`, and `SendMoney` are the use cases that encapsulate the business logic for the wallet feature.

### Presentation Layer

- **`cubit`**: `WalletCubit` manages the state of the wallet screen. It interacts with the use cases to fetch data and updates the UI accordingly. `WalletState` represents the different states of the UI (e.g., loading, loaded, error).
- **`screens`**: `WalletScreen`, `SendMoneyScreen`, and `TransactionHistoryScreen` are the UI screens for the wallet feature.

## 8. Testing

The project includes unit tests for the data, domain, and presentation layers.
- **`mockito`** is used to create mock objects for dependencies.
- **`bloc_test`** is used to test the `WalletCubit`.
- Fixtures are used to provide mock data for tests. They are located in the `test/fixtures` directory.
