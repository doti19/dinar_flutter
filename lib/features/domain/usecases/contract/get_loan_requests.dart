import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/features/domain/entities/credit/loan_request.dart';
import 'package:dinar/features/domain/repository/request_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetRequestUseCase
    implements
        UseCase<DataState<Pair<int, List<LoanRequestEntity>>>,
            Pair<String?, int?>?> {
  final RequestRepository _requestRepository;

  GetRequestUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> call(
      {Pair<String?, int?>? params}) {
    if (params == null) {
      return _requestRepository.getRequests(null, null);
    }
    return _requestRepository.getRequests(params.first, params.second);
  }
}
