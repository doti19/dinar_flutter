import 'package:dinar/core/constants/constants.dart';
import 'package:dinar/core/errors/exceptions.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/core/utils/typedef.dart';
import 'package:dinar/di/injection_container.dart';
import 'package:dinar/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:dinar/features/data/models/credit/bid.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/usecases/bid/remote/create_bid.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

abstract class BidRemoteDataSrc {
  Future<HttpResponse<Pair<int, List<BidModel>>>> getBidsByPost(
      String idPost, int? page);
  Future<HttpResponse<void>> createBid(BidParams bid);
  Future<HttpResponse<void>> updateBid(BidModel bid);
  Future<HttpResponse<void>> deleteBid(BidModel bid);
  Future<HttpResponse<void>> approveBid(String id);
  Future<HttpResponse<void>> rejectBid(String id);
  Future<HttpResponse<void>> declineBid(String id);
  Future<HttpResponse<void>> acceptBid(String id);

  Future<HttpResponse<Pair<int, List<BidModel>>>> getMyBids(int? page);
  Future<HttpResponse<Pair<int, List<BidModel>>>> getBidsStatus(
      String postId, String status, int? page);
}

class BidRemoteDataSrcImpl implements BidRemoteDataSrc {
  final Dio client;
  BidRemoteDataSrcImpl(this.client);
  @override
  Future<HttpResponse<void>> approveBid(String id) {
    var url = '$apiUrl$kGetBidEndpoint/$id/approve';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .patch(url,
              options: Options(
                  sendTimeout: const Duration(seconds: 10),
                  headers: {'Authorization': 'Bearer $accessToken'}))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> createBid(BidParams bid) {
    const url = '$apiUrl$kGetBidEndpoint';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .post('$url/${bid.postId}/bid',
              options: Options(
                  sendTimeout: const Duration(seconds: 10),
                  headers: {'Authorization': 'Bearer $accessToken'}),
              data: bid.toJson())
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> deleteBid(BidModel bid) {
    var url = '$apiUrl$kGetBidEndpoint/${bid.id}';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .delete(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<Pair<int, List<BidModel>>>> getBidsByPost(
      String idPost, int? page) {
    var url = '$apiUrl$kGetBidEndpoint/$idPost/bid';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        final int numOfPages = response.data["num_of_pages"];
        final List<DataMap> taskDataList =
            List<DataMap>.from(response.data["result"]);
        List<BidModel> bids = taskDataList
            .map((postJson) => BidModel.fromJson(postJson))
            .toList();
        final value = Pair(numOfPages, bids);
        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<HttpResponse<Pair<int, List<BidModel>>>> getBidsStatus(
      String postId, String status, int? page) {
    var url = '$apiUrl$kGetBidEndpoint/$postId/$status&page=$page';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        final int numOfPages = response.data["num_of_pages"];
        final List<DataMap> taskDataList =
            List<DataMap>.from(response.data["result"]);
        List<BidModel> bids = taskDataList
            .map((postJson) => BidModel.fromJson(postJson))
            .toList();
        final value = Pair(numOfPages, bids);
        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<HttpResponse<Pair<int, List<BidModel>>>> getMyBids(int? page) {
    var url = '$apiUrl$kGetBidEndpoint/my&page=$page';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        final int numOfPages = response.data["num_of_pages"];
        final List<DataMap> taskDataList =
            List<DataMap>.from(response.data["result"]);
        List<BidModel> bids = taskDataList
            .map((postJson) => BidModel.fromJson(postJson))
            .toList();
        final value = Pair(numOfPages, bids);
        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<HttpResponse<void>> rejectBid(String id) {
    var url = '$apiUrl$kGetBidEndpoint/$id/reject';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .patch(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> updateBid(BidModel bid) {
    var url = '$apiUrl$kGetBidEndpoint/${bid.id}';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .put(url,
              options: Options(
                  sendTimeout: const Duration(seconds: 10),
                  headers: {'Authorization': 'Bearer $accessToken'}),
              data: bid.toJson())
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> acceptBid(String id) {
    var url = '$apiUrl$kGetBidEndpoint/$id/accept';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .patch(url,
              options: Options(
                  sendTimeout: const Duration(seconds: 10),
                  headers: {'Authorization': 'Bearer $accessToken'}))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> declineBid(String id) {
    var url = '$apiUrl$kGetBidEndpoint/$id/decline';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw ApiException(message: 'Token is null', statusCode: 401);
      }

      return client
          .patch(url,
              options: Options(
                  sendTimeout: const Duration(seconds: 10),
                  headers: {'Authorization': 'Bearer $accessToken'}))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
