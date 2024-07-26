import 'dart:io';

import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/features/data/data_sources/local/secure_user_storage.dart';
import 'package:dinar/features/data/data_sources/remote/user_remote_data_source.dart';
import 'package:dinar/features/domain/entities/credit/user.dart';
import 'package:dinar/features/domain/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../../core/resources/pair.dart';
import '../models/credit/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSrc _userRemoteDataSrc;
  final UserStorage _userStorage;

  UserRepositoryImpl(this._userRemoteDataSrc, this._userStorage);

  @override
  Future<DataState<Pair<int, List<UserModel>>>> searchUsers(
      String query, int page) async {
    try {
      final httpResponse = await _userRemoteDataSrc.searchUsers(query, page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
  Future<DataState<UserEntity>> getProfile() async {
    try {
      final httpResponse = await _userRemoteDataSrc.getProfile();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        await _userStorage.saveUser(httpResponse.data);
        print('haki ${httpResponse.data.avatar}');
        imageCache.clear();
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
