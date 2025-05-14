import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';

class RejectBidUseCase implements UseCase<void, String> {
  final BidRepository _repository;

  RejectBidUseCase(this._repository);

  @override
  Future<void> call({String? params}) async {
    await _repository.rejectBid(params!);
  }
}
