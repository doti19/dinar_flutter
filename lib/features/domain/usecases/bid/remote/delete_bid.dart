import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';

class DeleteBidUseCase implements UseCase<DataState<void>, BidEntity> {
  final BidRepository repository;

  DeleteBidUseCase(this.repository);

  @override
  Future<DataState<void>> call({BidEntity? params}) {
    return repository.deleteBid(params!);
  }
}
