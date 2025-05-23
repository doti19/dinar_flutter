import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthenLocalDataSrc {
  Future<void> storeRefreshToken(String refreshToken);
  Future<void> storeAccessToken(String accessToken);
  String? getRefreshToken();
  String? getAccessToken();
  Future<void> deleteRefreshToken();
  Future<void> deleteAccessToken();
  String getUserIdFromToken();

  //TODO delete these later
  Future<void> persistLoginState(bool isLoggedIn);
  Future<bool> getLoginState();
}

class AuthenLocalDataSrcImpl implements AuthenLocalDataSrc {
  late SharedPreferences client;
  AuthenLocalDataSrcImpl(this.client);

  @override
  Future<void> persistLoginState(bool isLoggedIn) async {
    try {
      await client.setBool('isLoggedIn', isLoggedIn);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  Future<bool> getLoginState() async {
    try {
      return client.getBool('isLoggedIn') ?? false;
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  String? getSharedPreferencesValue(String key) {
    try {
      return client.getString(key);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  Future<void> setSharedPreferencesValue(String key, String value) async {
    try {
      await client.setString(key, value);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  Future<void> removeSharedPreferencesValue(String key) async {
    try {
      await client.remove(key);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  String? getAccessToken() {
    return getSharedPreferencesValue('accessToken');
  }

  @override
  String? getRefreshToken() {
    return getSharedPreferencesValue('refreshToken');
  }

  @override
  Future<void> storeAccessToken(String accessToken) async {
    setSharedPreferencesValue('accessToken', accessToken);
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) async {
    setSharedPreferencesValue('refreshToken', refreshToken);
  }

  @override
  Future<void> deleteAccessToken() async {
    removeSharedPreferencesValue('accessToken');
  }

  @override
  Future<void> deleteRefreshToken() async {
    removeSharedPreferencesValue('refreshToken');
  }

  @override
  String getUserIdFromToken() {
    try {
      String? token = client.getString('accessToken');
      if (JwtDecoder.isExpired(token!)) {
        throw const SharedPreferencesException(
            message: "Token is expired", statusCode: 500);
      }
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print('haki $decodedToken');
      return decodedToken["id"];
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }
}
