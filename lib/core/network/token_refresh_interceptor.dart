import 'package:asood/core/storage/token_storage.dart';
import 'package:dio/dio.dart';

final class TokenRefreshInterceptor extends Interceptor {
  TokenRefreshInterceptor({
    required Dio client,
    required TokenStorage tokenStorage,
    required String baseUrl,
    required String refreshPath,
  }) : _client = client,
       _tokenStorage = tokenStorage,
       _refreshClient = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           headers: {'Content-Type': 'application/json; charset=utf-8'},
         ),
       ),
       _refreshPath = refreshPath;

  static const _retriedKey = 'token_refresh_retried';

  final Dio _client;
  final Dio _refreshClient;
  final TokenStorage _tokenStorage;
  final String _refreshPath;
  Future<String?>? _activeRefresh;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    final shouldRefresh =
        err.response?.statusCode == 401 &&
        request.path != _refreshPath &&
        request.extra[_retriedKey] != true;

    if (!shouldRefresh) {
      handler.next(err);
      return;
    }

    final accessToken = await _refreshAccessToken();
    if (accessToken == null) {
      handler.next(err);
      return;
    }

    request.extra[_retriedKey] = true;
    request.headers['Authorization'] = 'Bearer $accessToken';

    try {
      final response = await _client.fetch<dynamic>(request);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<String?> _refreshAccessToken() async {
    final runningRefresh = _activeRefresh;
    if (runningRefresh != null) {
      return runningRefresh;
    }

    final refresh = _performRefresh();
    _activeRefresh = refresh;
    try {
      return await refresh;
    } finally {
      _activeRefresh = null;
    }
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null) {
      await _tokenStorage.clearTokens();
      return null;
    }

    try {
      final response = await _refreshClient.post<dynamic>(
        _refreshPath,
        data: {'refresh': refreshToken},
      );
      final tokens = _readTokens(response.data);
      if (tokens == null) {
        await _tokenStorage.clearTokens();
        return null;
      }

      await _tokenStorage.writeTokens(
        accessToken: tokens.$1,
        refreshToken: tokens.$2,
      );
      return tokens.$1;
    } on DioException {
      await _tokenStorage.clearTokens();
      return null;
    }
  }

  (String, String?)? _readTokens(dynamic body) {
    if (body is! Map) {
      return null;
    }

    final root = Map<String, dynamic>.from(body);
    final rawData = root['data'];
    final data = rawData is Map ? Map<String, dynamic>.from(rawData) : root;
    final rawJwt = data['jwt'];
    final jwt = rawJwt is Map ? Map<String, dynamic>.from(rawJwt) : data;
    final access = jwt['access']?.toString();
    if (access == null || access.isEmpty) {
      return null;
    }
    return (access, jwt['refresh']?.toString());
  }
}
