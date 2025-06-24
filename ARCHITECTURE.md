# Flutter Base Project - Clean Architecture

## Project Structure

This project follows Clean Architecture principles with the following layer structure:

```
lib/
├── core/                          # Core functionality 
│   ├── di/                        # Dependency Injection
│   ├── error/                     # Error handling
│   ├── network/                   # Network configurations
│   ├── router/                    # Navigation routing
│   └── usecase/                   # Base use case classes
├── features/                      # Feature modules
│   └── user/                      # User feature example
│       ├── data/                  # Data layer
│       │   ├── datasources/       # Data sources (API, local)
│       │   ├── models/            # Data models
│       │   └── repositories/      # Repository implementations
│       ├── domain/                # Domain layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Business logic
│       └── presentation/          # Presentation layer
│           ├── bloc/              # BLoC state management
│           ├── pages/             # UI pages
│           └── widgets/           # Reusable widgets
├── flavors.dart                   # App flavors configuration
├── main.dart                      # Main entry point
├── main_develop.dart              # Development entry point
├── main_staging.dart              # Staging entry point
└── main_production.dart           # Production entry point
```

## Architecture Layers

### 1. Presentation Layer
- **BLoC**: State management using flutter_bloc
- **Pages**: UI screens and pages
- **Widgets**: Reusable UI components

### 2. Domain Layer
- **Entities**: Core business objects
- **Use Cases**: Business logic operations
- **Repositories**: Abstract interfaces for data operations

### 3. Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: API services and local storage
- **Repository Implementations**: Concrete implementations of domain repositories

## Key Technologies

### State Management
- **flutter_bloc**: For predictable state management
- **equatable**: For value equality without boilerplate

### Networking
- **dio**: HTTP client for API calls
- **retrofit**: Type-safe REST client generator
- **pretty_dio_logger**: Logging for network requests

### Navigation
- **go_router**: Declarative routing solution

### Code Generation
- **json_annotation**: JSON serialization annotations
- **build_runner**: Code generation tool
- **injectable**: Dependency injection code generation

### Development Tools
- **freezed**: Code generation for data classes
- **bloc_test**: Testing utilities for BLoC
- **mocktail**: Mocking library for tests

## App Flavors

The project supports three flavors:
- **Development**: For development environment
- **Staging**: For testing environment  
- **Production**: For production environment

Each flavor has:
- Different app names and bundle IDs
- Different API endpoints
- Different configurations

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Generate code:
```bash
flutter packages pub run build_runner build
```

3. Run the app with desired flavor:
```bash
# Development
flutter run --flavor develop -t lib/main_develop.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor production -t lib/main_production.dart
```

## VSCode Configuration

The project includes VSCode launch configurations for debugging all flavors in different modes (debug, profile, release).

## Testing

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for full user flows

Run tests with:
```bash
flutter test
```

## Best Practices

1. **Separation of Concerns**: Each layer has specific responsibilities
2. **Dependency Inversion**: High-level modules don't depend on low-level modules
3. **Single Responsibility**: Each class has one reason to change
4. **Testability**: Architecture supports easy unit testing
5. **Code Generation**: Reduces boilerplate and maintains consistency 