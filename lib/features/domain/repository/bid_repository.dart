import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/usecases/bid/remote/create_bid.dart';

abstract class BidRepository {
  // API remote
  // Future<DataState<Pair<int, List<BidEntity>>>> getBids(String? idUser, int? page);
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsByPost(
      String idPost, int? page);
  // Future<DataState<BidEntity>> getSingleBid(String id);
  Future<DataState<void>> createBid(BidParams bid);
  Future<DataState<void>> updateBid(BidEntity bid);
  Future<DataState<void>> deleteBid(BidEntity bid);
  Future<DataState<void>> approveBid(String id);
  Future<DataState<void>> rejectBid(String id);
  Future<DataState<void>> acceptBid(String id);

  Future<DataState<void>> declineBid(String id);

  Future<DataState<Pair<int, List<BidEntity>>>> getMybids(int? page);
  // management
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsApproved(
      String postId, int? page);
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsPending(
      String postId, int? page);
  Future<DataState<Pair<int, List<BidEntity>>>> getBidsRejected(
      String postId, int? page);
}
