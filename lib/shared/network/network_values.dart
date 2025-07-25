class EndPoints {
  // Authentication endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh';

  // User endpoints
  static const String userProfile = 'user/profile';
  static String updateUser(String userId) => 'user/$userId';

  // Wallet endpoints
  static const String walletBalance = 'wallet/balance';
  static const String walletTransactions = 'wallet/transactions';
  static String walletTransfer(String walletId) => 'wallet/$walletId/transfer';

  // Transaction endpoints
  static const String recentTransactions = 'transactions/recent';
  static String transactionDetails(String transactionId) =>
      'transactions/$transactionId';
}

class Params {
  // Common parameters
  static const String apiKey = 'api_key';
  static const String authToken = 'Authorization';

  // Pagination
  static const String page = 'page';
  static const String limit = 'limit';

  // User parameters
  static const String email = 'email';
  static const String password = 'password';
  static const String name = 'name';
  static const String phone = 'phone';

  // Wallet parameters
  static const String amount = 'amount';
  static const String currency = 'currency';
  static const String recipient = 'recipient';
  static const String note = 'note';

  // Transaction parameters
  static const String startDate = 'start_date';
  static const String endDate = 'end_date';
  static const String type = 'type';
}
