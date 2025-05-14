import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';

class ApproveBidUseCase implements UseCase<DataState<void>, String> {
  final BidRepository _repository;

  ApproveBidUseCase(this._repository);

  @override
  Future<DataState<void>> call({String? params}) async {
    return _repository.approveBid(params!);
  }
}
