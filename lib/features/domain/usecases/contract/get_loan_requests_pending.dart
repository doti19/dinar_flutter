import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/features/domain/entities/credit/loan_request.dart';
import 'package:dinar/features/domain/repository/request_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetRequestPendingUseCase
    implements UseCase<DataState<Pair<int, List<LoanRequestEntity>>>, int?> {
  final RequestRepository _requestRepository;

  GetRequestPendingUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> call({int? params}) {
    return _requestRepository.getRequestsPending(params);
  }
}
