import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';

class GetMyBidsUseCase
    implements UseCase<DataState<Pair<int, List<BidEntity>>>, int?> {
  final BidRepository _repository;

  GetMyBidsUseCase(this._repository);

  @override
  Future<DataState<Pair<int, List<BidEntity>>>> call({int? params}) async {
    //  if(params == null){
    //    return Pair(0, []);
    //  }
    return await _repository.getMybids(params);
  }
}
