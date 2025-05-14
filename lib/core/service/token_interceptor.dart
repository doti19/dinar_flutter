import 'dart:convert';

import 'package:dinar/core/constants/constants.dart';
import 'package:dinar/di/injection_container.dart';
import 'package:dinar/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:dinar/features/presentation/modules/login/screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      try {
        RequestOptions options = err.requestOptions;

        // Assuming refreshToken() is your method to refresh the token
        // and it returns the new token

        String newToken = await refreshToken();

        // Update the authorization header with the new token
        options.headers["Authorization"] = "Bearer $newToken";

        // Retry the request with the new token
        // final cloneReq = await http.(options);
        // return handler.next({options});
      } on DioException catch (e) {
        print('rejectede');
        // return handler.reject(e);
      } catch (e) {
        print('rejected');
        logoutUser();
        // return handler.reject(DioException.badCertificate(
        //     requestOptions: RequestOptions(path: '')));
        // return handler.handler);
      }
    }

    // For all other errors, just continue
    handler.next(err);
  }

  Future<void> logoutUser() async {
    // Clear stored user data
    print('ayayayaya');
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    await localDataSrc.deleteAccessToken();
    await localDataSrc.deleteRefreshToken();

    // Navigate to the login screen
    // Assuming you have access to the BuildContext
    Navigator.of(sl<BuildContext>()).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
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
    final refresh_token = jsonDecode(response.body)['tokens']['refreshToken'];
    localDataSrc.storeAccessToken(token);
    localDataSrc.storeRefreshToken(refresh_token);
    // return getUser();
    return refresh_token;
  }
}
