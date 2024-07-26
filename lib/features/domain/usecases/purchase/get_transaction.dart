import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/transaction_repository.dart';
import '../../entities/credit/transaction.dart';

class GetTransactionUseCase
    implements UseCase<DataState<TransactionEntity>, String> {
  final TransactionRepository _transtractionRepository;

  GetTransactionUseCase(this._transtractionRepository);

  @override
  Future<DataState<TransactionEntity>> call({String? params}) {
    return _transtractionRepository.getTransactionByAppTransId(params!);
  }
}
