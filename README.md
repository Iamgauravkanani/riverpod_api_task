# Riverpod Example App

A Flutter application demonstrating best practices for state management using Riverpod, with a scalable API architecture.

![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.3.0-blue.svg)
![Riverpod](https://img.shields.io/badge/Riverpod-2.4.10-green.svg)

## 📱 Features

- Clean Architecture implementation
- Riverpod state management
- Scalable API service architecture
- Error handling and logging
- Material 3 design
- Dark/Light theme support
- Responsive UI

## 🏗️ Architecture

The project follows a clean architecture approach with the following structure:

```
lib/
├── main.dart                 # Application entry point
├── model/                    # Data models
│   └── datamodel.dart        # User data model
├── provider/                 # State management and API services
│   ├── api_config.dart       # API configuration
│   ├── base_api_service.dart # Base API service
│   └── data_provider.dart    # Data providers
└── views/                    # UI components
    └── data.dart             # Data screen
```

### Key Components

#### API Layer
- `BaseApiService`: Abstract base class for API services
- `ApiConfig`: Centralized API configuration
- Domain-specific services (e.g., `UserApiService`)

#### State Management
- Riverpod providers for state management
- Future providers for async operations
- Provider scoping for dependency injection

#### UI Layer
- Material 3 design implementation
- Responsive layouts
- Theme support

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.19.0 or higher)
- Dart SDK (3.3.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/riverpod_example_app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd riverpod_example_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 💻 Usage

### API Services

The app uses a base API service class that can be extended for different API endpoints:

```dart
class UserApiService extends BaseApiService {
  Future<UserModel?> fetchUser() async {
    return get<UserModel>(
      endpoint: ApiConfig.users,
      fromJson: UserModel.fromJson,
    );
  }
}
```

### State Management

State is managed using Riverpod providers:

```dart
final dataProvider = FutureProvider<UserModel?>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchUser();
});
```

### UI Components

The UI follows Material 3 design guidelines and supports both light and dark themes.

## 🛠️ Development

### Adding New API Endpoints

1. Add the endpoint to `ApiConfig`:
   ```dart
   static const String newEndpoint = '/new-endpoint';
   ```

2. Create a new service class:
   ```dart
   class NewApiService extends BaseApiService {
     Future<NewModel?> fetchData() async {
       return get<NewModel>(
         endpoint: ApiConfig.newEndpoint,
         fromJson: NewModel.fromJson,
       );
     }
   }
   ```

3. Create providers:
   ```dart
   final newServiceProvider = Provider<NewApiService>((ref) => NewApiService());
   final newDataProvider = FutureProvider<NewModel?>((ref) async {
     final service = ref.watch(newServiceProvider);
     return service.fetchData();
   });
   ```

### Error Handling

The app implements comprehensive error handling:
- Network errors
- Timeout handling
- JSON parsing errors
- HTTP status code handling

### Logging

Logging is implemented throughout the app:
- API requests and responses
- Error tracking
- State changes

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.10
  http: ^1.2.0
  cupertino_icons: ^1.0.8
```

## 🧪 Testing

Run tests using:
```bash
flutter test
```

## 📝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- Your Name - Initial work

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod team for the state management solution
- Random Data API for the test data
