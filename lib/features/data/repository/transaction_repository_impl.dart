import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/features/data/data_sources/remote/transaction_data_source.dart';
import '../../domain/entities/credit/transaction.dart';
import '../../domain/repository/transaction_repository.dart';

class TranstractionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSrc _transtractionDataSource;

  TranstractionRepositoryImpl(this._transtractionDataSource);

  @override
  Future<DataState<TransactionEntity>> getTransactionByAppTransId(
      String id) async {
    try {
      final httpResponse =
          await _transtractionDataSource.getTransactionByAppTransId(id);

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
}
