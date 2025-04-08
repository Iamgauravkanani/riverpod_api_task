class ApiConfig {
  static const String baseUrl = 'https://random-data-api.com/api/v2';
  
  // API Endpoints
  static const String users = '/users';
  static const String posts = '/posts';
  static const String comments = '/comments';
  
  // API Timeouts
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  
  // API Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // API Error Messages
  static const String timeoutError = 'Request timed out';
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'An unknown error occurred';
} 