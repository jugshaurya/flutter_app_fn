import 'package:dio/dio.dart';
import 'package:fs_app/config/environment_config.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/utils/log.dart';

class NetworkService {
  late final Dio _dio;
  late final Dio _dioWithHeaders;
  late final SharedPreferenceService _prefs;

  NetworkService(
    this._prefs,
  ) {
    _dio = Dio();
    _dioWithHeaders = Dio()..interceptors.add(_DioHeaderInterceptor(_prefs));
  }

  Response? _handleResponse(Response? response) {
    int statusCode = response == null ? 0 : (response.statusCode ?? 0);
    if (statusCode == 401) {
      Log.logger.w("401:: logout");
      _prefs.clearData();
    }
    return response;
  }

  Future get(String url,
      {Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    try {
      String finalUrl = EnvironmentConfig.config.apiBaseUrl! + url;
      Log.logger.d('GetRequest \n $finalUrl');
      Response response = await _dioWithHeaders.get(finalUrl);
      Log.logger.d("GetResponse: ${response.data}");
      if (onSuccess != null) {
        onSuccess(response.data);
      }
      return response;
    } on DioError catch (error) {
      Log.logger.e("GetResponse Error: ${error.response}");
      if (onError != null) {
        onError(error.response);
      }
      return error.response;
    }
  }

  Future post(
    String url, {
    dynamic body,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      String finalUrl = EnvironmentConfig.config.apiBaseUrl! + url;
      Log.logger.d('PostRequest \n $finalUrl, body: $body');
      Response response = await _dioWithHeaders.post(finalUrl, data: body);
      Log.logger.d("PostResponse: ${response.data}");
      if (onSuccess != null) {
        onSuccess(response.data);
      }
      return response;
    } on DioError catch (error) {
      Log.logger.e("PostResponse error: ${error.response}");
      if (onError != null) {
        onError(error.response);
      }
      return error.response;
    }
  }

  Future delete(
    String url, {
    dynamic body,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      String finalUrl = EnvironmentConfig.config.apiBaseUrl! + url;
      Log.logger.d('DeleteRequest \n $finalUrl, body: $body');
      Response response = await _dioWithHeaders.delete(finalUrl, data: body);
      Log.logger.d("DeleteResponse: ${response.data}");
      if (onSuccess != null) {
        onSuccess(response.data);
      }
      return response;
    } on DioError catch (error) {
      Log.logger.e("DeleteResponse error: ${error.response}");
      if (onError != null) {
        onError(error.response);
      }
      return error.response;
    }
  }
}

class _DioHeaderInterceptor extends Interceptor {
  final SharedPreferenceService _prefs;

  _DioHeaderInterceptor(this._prefs);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? authToken = _prefs.getAuthToken();
    options.headers['Content-Type'] = 'application/json';
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = authToken;
    } else {
      // to do get authtoken from authenticate api
    }
    Log.logger.d("Headers: ${options.headers}");
    super.onRequest(options, handler);
  }
}
