import 'dart:convert';
import 'dart:io';
import 'package:dinar/core/utils/typedef.dart';
import 'package:dinar/features/data/data_sources/local/secure_user_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/resources/data_state.dart';
import '../../domain/repository/authentication_repository.dart';
import '../data_sources/local/authentication_local_data_source.dart';
import '../data_sources/remote/authentication_remote_data_source.dart';
import '../models/credit/user.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenRemoteDataSrc _dataRemoteSrc;
  final AuthenLocalDataSrc _dataLocalSrc;
  final UserStorage _userStorage;

  bool _isLoggedIn = false;
  AuthenticationRepositoryImpl(
      this._dataRemoteSrc, this._dataLocalSrc, this._userStorage) {
    _dataLocalSrc.getLoginState().then((value) {
      print(value);
      _isLoggedIn = value;
      notifyAuthStateListeners();
    });
  }

  @override
  Future<DataState<void>> signIn(String email, String password) async {
    try {
      final httpResponse = await _dataRemoteSrc.login(email, password);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        String accessToken = httpResponse.data['accessToken']!;
        String refreshToken = httpResponse.data['refreshToken']!;
        _dataLocalSrc.storeAccessToken(accessToken);
        _dataLocalSrc.storeRefreshToken(refreshToken);
        isLoggedIn = true;
        // _dataLocalSrc.persistLoginState(isLoggedIn);
        //  final DataMap data = DataMap.from(httpResponse.data["user"]);

        Map<String, dynamic> userMap = httpResponse.response.data['user']!;
        // json.decode(httpResponse.response.data['user']!);
        UserModel user = UserModel.fromJson(userMap);

        print('megalawa $user');
        _userStorage.saveUser(user);
        return const DataSuccess(null);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      print('error: $e');
      return DataFailed(DioException(
        error: e.toString(),
        type: DioExceptionType.badCertificate,
        requestOptions: RequestOptions(path: ""),
      ));
    }
  }

  @override
  DataState<bool> checkActiveToken() {
    try {
      String? accessToken = _dataLocalSrc.getAccessToken();
      if (accessToken != "" &&
          JwtDecoder.isExpired(accessToken ?? "") == false) {
        return const DataSuccess(true);
      }
      return const DataSuccess(false);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<bool> checkRefreshTokenIsValid() {
    try {
      String? refreshToken = _dataLocalSrc.getRefreshToken();
      if (refreshToken != "" &&
          JwtDecoder.isExpired(refreshToken ?? "") == false) {
        return const DataSuccess(true);
      }
      return const DataSuccess(false);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> refreshNewAccessToken() async {
    try {
      final refreshToken = _dataLocalSrc.getRefreshToken();
      final httpResponse = await _dataRemoteSrc.refreshToken(refreshToken!);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        String accessToken = httpResponse.data['accessToken']!;
        String refreshToken = httpResponse.data['refreshToken']!;
        _dataLocalSrc.storeAccessToken(accessToken);
        _dataLocalSrc.storeRefreshToken(refreshToken);
        isLoggedIn = true;
        return const DataSuccess(null);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      return DataFailed(DioException(
        error: e.toString(),
        type: DioExceptionType.badCertificate,
        requestOptions: RequestOptions(path: ""),
      ));
    }
  }

  @override
  Future<DataState<void>> signOut() async {
    try {
      final httpResponse = await _dataRemoteSrc.signOut();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _dataLocalSrc.deleteAccessToken();
        _dataLocalSrc.deleteRefreshToken();
        isLoggedIn = false;
        return const DataSuccess(null);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> signUp(
      String email,
      String password,
      String confirmPassword,
      String firstName,
      String lastName,
      String phoneNumber) async {
    try {
      final httpResponse = await _dataRemoteSrc.signUp(
          email, password, confirmPassword, firstName, lastName, phoneNumber);
      print('tsega ${httpResponse.response}');
      if (httpResponse.response.statusCode == HttpStatus.created) {
        print(' hello ${httpResponse.data}');
        String otp = httpResponse.data;
        return DataSuccess(otp);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> updateProfile(File? avatar) async {
    try {
      final httpResponse = await _dataRemoteSrc.updateProfile(avatar);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Map<String, dynamic> userMap = httpResponse.response.data['user']!;
        // json.decode(httpResponse.response.data['user']!);
        // UserModel user = UserModel.fromJson(userMap);

        // print('megalawa $user');
        await _userStorage.saveUser(httpResponse.data);
        print('haki3 ${httpResponse.data.avatar}');
        imageCache.clear();

        // getMe();
        // UserModel? user = await _userStorage.readUser();
        // user.avatar = httpResponse.data;
        // print('emheleu ${httpResponse.data.}');
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<String> getUserId() {
    try {
      String id = _dataLocalSrc.getUserIdFromToken();
      return DataSuccess(id);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<String> getAccessToken() {
    final accessToken = _dataLocalSrc.getAccessToken();
    return DataSuccess(accessToken);
  }

  final List<Function(bool p1)> _authListeners = [];

  @override
  void addAuthStateListener(Function(bool p1) listener) {
    _authListeners.add(listener);
  }

  @override
  void removeAuthStateListener(Function(bool p1) listener) {
    _authListeners.remove(listener);
  }

  @override
  void notifyAuthStateListeners() {
    for (var listener in _authListeners) {
      listener(_isLoggedIn);
    }
  }

  @override
  bool get isLoggedIn => _isLoggedIn;

  @override
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyAuthStateListeners();
  }

  @override
  Future<DataState<void>> signInWithToken() async {
    final refreshToken = _dataLocalSrc.getRefreshToken();
    if (JwtDecoder.isExpired(refreshToken ?? "") == false) {
      final result = await refreshNewAccessToken();
      if (result is DataSuccess) {
        isLoggedIn = true;
        return const DataSuccess(null);
      } else {
        return DataFailed(DioException(
          error: "Refresh token is invalid",
          type: DioExceptionType.badCertificate,
          requestOptions: RequestOptions(path: ""),
        ));
      }
    } else {
      return DataFailed(DioException(
        error: "Refresh token is invalid",
        type: DioExceptionType.badCertificate,
        requestOptions: RequestOptions(path: ""),
      ));
    }
  }

  @override
  Future<DataState<UserModel>> getMe() async {
    try {
      final httpResponse = await _dataRemoteSrc.getMe();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // print('hakki');
        // await _userStorage.saveUser(httpResponse.data);
        // print('haki1 ${httpResponse.data.avatar}');
        // imageCache.clear();

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
