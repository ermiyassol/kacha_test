import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kacha_test/app/app_globals.dart';
import 'package:kacha_test/models/response/response.dart' as response;
import 'package:kacha_test/shared/network/network_service.dart';
import '../util/app_exception.dart';
import 'exception/mixin/network_handler_mixin.dart';
import 'network_values.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  late Dio dio;

  DioNetworkService() {
    dio = Dio();
    if (!kTestMode) {
      dio.options = dioBaseOptions;
      if (kDebugMode) {
        dio.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );
      }
    }
  }

  BaseOptions get dioBaseOptions => BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  );

  @override
  String get baseUrl => dotenv.env[NetworkEnv.BASE_URL.name] ?? '';

  @override
  String get apiKey => dotenv.env[NetworkEnv.API_KEY.name] ?? '';

  @override
  Map<String, Object> get headers => {
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  @override
  Map<String, dynamic>? updateHeaders(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    if (!kTestMode) {
      dio.options.headers = headers;
    }
    return header;
  }

  @override
  Future<Either<AppException, response.Response>> get(
    String endPoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    // Return default data for specific endpoints
    if (endPoint == '/auth/login') {
      final defaultData = {
        "user": {
          "id": 1,
          "email": "user@example.com",
          "name": "John Doe",
          "phone": "+1234567890",
          "token": "user_token_123",
        },
        "token": "auth_token_456",
      };
      return Right(
        response.Response(
          statusCode: 200,
          statusMessage: "OK",
          data: defaultData,
        ),
      );
    } else if (endPoint == '/wallet/balance' ||
        endPoint == '/wallet/transactions') {
      final defaultData = {
        "wallet": {
          "id": 1,
          "balance": 1250.75,
          "currency": "USD",
          "lastUpdated": "2023-11-15T14:30:45Z",
        },
        "transactions": [
          {
            "id": 101,
            "transactionId": "TX-2023-101",
            "amount": 150.0,
            "currency": "USD",
            "recipientName": "John Doe",
            "recipientAccount": "ACC-789012",
            "date": "2023-11-10T09:15:22Z",
            "status": "completed",
            "note": "Invoice #1234",
          },
          {
            "id": 102,
            "transactionId": "TX-2023-102",
            "amount": -75.25,
            "currency": "USD",
            "recipientName": "Amazon Inc",
            "recipientAccount": "ACC-345678",
            "date": "2023-11-12T16:45:10Z",
            "status": "completed",
            "note": "Online purchase",
          },
        ],
      };
      return Right(
        response.Response(
          statusCode: 200,
          statusMessage: "OK",
          data: defaultData,
        ),
      );
    } else if (endPoint == '/transfers/send') {
      final defaultData = {
        "transaction": {
          "id": 789,
          "transactionId": "XFER-2023-789",
          "amount": 250.0,
          "currency": "USD",
          "recipientName": "Sarah Johnson",
          "recipientAccount": "ACC-456789",
          "date": "2023-11-20T13:45:30Z",
          "status": "completed",
          "note": "Freelance payment",
        },
      };
      return Right(
        response.Response(
          statusCode: 200,
          statusMessage: "OK",
          data: defaultData,
        ),
      );
    }

    // Original network call for other endpoints
    queryParams ??= {};
    queryParams[Params.apiKey] = apiKey;
    final res = handleException(
      () => dio.get(endPoint, queryParameters: queryParams),
      endPoint: endPoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> post(
    String endPoint, {
    Map<String, dynamic>? data,
  }) async {
    // Return default data for specific endpoints
    if (endPoint == '/auth/login') {
      final defaultData = {
        "user": {
          "id": 1,
          "email": "user@example.com",
          "name": "John Doe",
          "phone": "+1234567890",
          "token": "user_token_123",
        },
        "token": "auth_token_456",
      };
      return Right(
        response.Response(
          statusCode: 200,
          statusMessage: "OK",
          data: defaultData,
        ),
      );
    } else if (endPoint == '/wallet/balance' ||
        endPoint == '/wallet/transactions') {
      final defaultData = {
        "wallet": {
          "id": 1,
          "balance": 1250.75,
          "currency": "USD",
          "lastUpdated": "2023-11-15T14:30:45Z",
        },
        "transactions": [
          {
            "id": 101,
            "transactionId": "TX-2023-101",
            "amount": 150.0,
            "currency": "USD",
            "recipientName": "John Doe",
            "recipientAccount": "ACC-789012",
            "date": "2023-11-10T09:15:22Z",
            "status": "completed",
            "note": "Invoice #1234",
          },
          {
            "id": 102,
            "transactionId": "TX-2023-102",
            "amount": -75.25,
            "currency": "USD",
            "recipientName": "Amazon Inc",
            "recipientAccount": "ACC-345678",
            "date": "2023-11-12T16:45:10Z",
            "status": "completed",
            "note": "Online purchase",
          },
        ],
      };
      return Right(
        response.Response(
          statusCode: 200,
          statusMessage: "OK",
          data: defaultData,
        ),
      );
    } else if (endPoint == '/transfers/send') {
      final defaultData = {
        "transaction": {
          "id": 789,
          "transactionId": "XFER-2023-789",
          "amount": 250.0,
          "currency": "USD",
          "recipientName": "Sarah Johnson",
          "recipientAccount": "ACC-456789",
          "date": "2023-11-20T13:45:30Z",
          "status": "completed",
          "note": "Freelance payment",
        },
      };
      return Right(
        response.Response(
          statusCode: 200,
          statusMessage: "OK",
          data: defaultData,
        ),
      );
    }

    // Original network call for other endpoints
    final res = handleException(
      () => dio.post(endPoint, data: data),
      endPoint: endPoint,
    );
    return res;
  }
}
