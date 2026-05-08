import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// HTTP client wrapper for handling all API requests with Dio
/// Manages authentication tokens, request/response interceptors, and error handling
class DioClient extends GetxService {
  late d.Dio dio;
  // final Logger logger = Logger("DIO logger");
  final GetStorage storage = GetStorage();

  static const String baseUrl = 'http://127.0.0.1:57000/api/v1';

  @override
  void onInit() {
    super.onInit();
    _initDio();
  }

  /// Initializes Dio instance with default configuration and interceptors
  void _initDio() {
    dio = d.Dio(
      d.BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for request/response handling
    dio.interceptors.add(
      d.InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );

    // // Add logger interceptor for development debugging
    // dio.interceptors.add(
    //   d.LogInterceptor(
    //     requestBody: true,
    //     responseBody: true,
    //     logPrint: (obj) => logger.log(Level.ALL, obj),
    //   ),
    // );
  }

  /// Request interceptor - adds authentication token to headers if available
  Future<void> _onRequest(
    d.RequestOptions options,
    d.RequestInterceptorHandler handler,
  ) async {
    // Retrieve stored access token
    final token = storage.read('access_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  /// Response interceptor - processes successful responses
  void _onResponse(d.Response response, d.ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  /// Error interceptor - handles token refresh on 401 unauthorized errors
  Future<void> _onError(
    d.DioException error,
    d.ErrorInterceptorHandler handler,
  ) async {
    // Attempt token refresh if unauthorized (token expired)
    if (error.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the original request with new token
        final opts = error.requestOptions;
        final cloneReq = await dio.request(
          opts.path,
          options: d.Options(method: opts.method, headers: opts.headers),
          data: opts.data,
          queryParameters: opts.queryParameters,
        );
        return handler.resolve(cloneReq);
      }
    }
    return handler.next(error);
  }

  /// Refreshes expired access token using refresh token
  /// Returns true if refresh successful, false otherwise
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = storage.read('refresh_token');
      if (refreshToken == null) return false;

      final response = await dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        await storage.write('access_token', response.data['access_token']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Generic GET request wrapper
  Future<d.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  /// Generic POST request wrapper
  Future<d.Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  /// Generic PUT request wrapper
  Future<d.Response> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  /// Generic DELETE request wrapper
  Future<d.Response> delete(String path) async {
    try {
      return await dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }
}
