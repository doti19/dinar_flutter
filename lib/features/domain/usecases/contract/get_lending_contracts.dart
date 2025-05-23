import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/features/domain/entities/credit/contract.dart';
import 'package:dinar/features/domain/repository/request_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetLendingContractsUseCase
    implements UseCase<DataState<Pair<int, List<ContractEntity>>>, int?> {
  final RequestRepository _requestRepository;

  GetLendingContractsUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<ContractEntity>>>> call({int? params}) {
    return _requestRepository.getLendingContract(params);
  }
}
