import 'dart:convert';

import 'package:dinar/core/constants/constants.dart';
import 'package:dinar/di/injection_container.dart';
import 'package:dinar/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class TokenInterceptor extends Interceptor {
  TokenInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // If the response is successful, just continue
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If error is 401 Unauthorized, try refreshing the token
    print('raya');
    if (err.response?.statusCode == 401) {
      RequestOptions options = err.requestOptions;

      // Assuming refreshToken() is your method to refresh the token
      // and it returns the new token
      String newToken = await refreshToken();

      // Update the authorization header with the new token
      options.headers["Authorization"] = "Bearer $newToken";

      // Retry the request with the new token
      try {
        // final cloneReq = await http.(options);
        // return handler.next({options});
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    // For all other errors, just continue
    handler.next(err);
  }

  Future<String> refreshToken() async {
    // Implement your token refresh logic here
    // For example, make a request to refresh the token and return the new token
    // This is just a placeholder implementation
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    String? refreshToken = localDataSrc.getRefreshToken();
    final response =
        await http.post(Uri.http('${ipConfig}', '/auth/refresh'), headers: {
      'grant_type': 'refresh_token',
    }, body: {
      'refreshToken': refreshToken
    });
    print(response);

    final token = jsonDecode(response.body)['tokens']['accessToken'];
    final refresh_token = jsonDecode(response.body)['tokens']['refresh_token'];
    localDataSrc.storeAccessToken(token);
    localDataSrc.storeRefreshToken(token);
    // return getUser();
    return refresh_token;
  }
}
