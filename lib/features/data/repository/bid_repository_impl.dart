import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/features/data/data_sources/remote/bid_remote_data_source.dart';
import 'package:dinar/features/data/models/credit/bid.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';
import 'package:dinar/features/domain/usecases/bid/remote/create_bid.dart';
import 'package:dio/dio.dart';

class BidRepositoryImpl implements BidRepository {
  final BidRemoteDataSrc _dataSrc;
  BidRepositoryImpl(this._dataSrc);

  @override
  Future<DataState<void>> approveBid(String id) async {
    try {
      final httpResponse = await _dataSrc.approveBid(id);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<void>> rejectBid(String id) async {
    try {
      final httpResponse = await _dataSrc.rejectBid(id);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<void>> createBid(BidParams bid) async {
    try {
      final httpResponse = await _dataSrc.createBid(bid);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<void>> deleteBid(BidEntity bid) async {
    try {
      final httpResponse = await _dataSrc.deleteBid(BidModel.fromEntity(bid));
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsApproved(
      String postId, int? page) async {
    try {
      final httpResponse =
          await _dataSrc.getBidsStatus(postId, 'approved', page);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsByPost(
      String idPost, int? page) async {
    try {
      final httpResponse = await _dataSrc.getBidsByPost(idPost, page);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsPending(
      String postId, int? page) async {
    try {
      final httpResponse =
          await _dataSrc.getBidsStatus(postId, 'pending', page);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsRejected(
      String postId, int? page) async {
    try {
      final httpResponse =
          await _dataSrc.getBidsStatus(postId, 'rejected', page);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<Pair<int, List<BidEntity>>>> getMybids(int? page) async {
    try {
      final httpResponse = await _dataSrc.getMyBids(page);
      if (httpResponse.response.statusCode == 200) {
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

  // @override
  // Future<DataState<BidEntity>> getSingleBid(String id) async{
  //  try{
  //     final httpResponse = await _dataSrc.getSingleBid(id);
  //     if (httpResponse.response.statusCode == 200) {
  //       return DataSuccess(httpResponse.data);
  //     } else {
  //       return DataFailed(DioException(
  //         error: httpResponse.response.statusMessage,
  //         response: httpResponse.response,
  //         type: DioExceptionType.badResponse,
  //         requestOptions: httpResponse.response.requestOptions,
  //       ));
  //     }
  //   } on DioException catch (e) {
  //     return DataFailed(e);
  //  }
  // }

  @override
  Future<DataState<void>> updateBid(BidEntity bid) async {
    try {
      final httpResponse = await _dataSrc.updateBid(BidModel.fromEntity(bid));
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<void>> acceptBid(String id) async {
    try {
      final httpResponse = await _dataSrc.acceptBid(id);
      if (httpResponse.response.statusCode == 200) {
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
  Future<DataState<void>> declineBid(String id) async {
    try {
      final httpResponse = await _dataSrc.declineBid(id);
      if (httpResponse.response.statusCode == 200) {
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
