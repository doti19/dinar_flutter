import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';

class GetBidsByPostUseCase
    implements
        UseCase<DataState<Pair<int, List<BidEntity>>>, Pair<String, int?>?> {
  final BidRepository _bidRepository;
  GetBidsByPostUseCase(this._bidRepository);

  @override
  Future<DataState<Pair<int, List<BidEntity>>>> call(
      {Pair<String, int?>? params}) {
    if (params == null) {
      return _bidRepository.getBidsByPost(params!.first, null);
    }
    return _bidRepository.getBidsByPost(params.first, params.second);
  }
}
