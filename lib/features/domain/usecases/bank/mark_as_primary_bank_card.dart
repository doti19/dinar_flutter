import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/bank_repository.dart';

class MarkAsPrimaryBankCardsUseCase implements UseCase<void, String> {
  final BankRepository _bankRepository;

  MarkAsPrimaryBankCardsUseCase(this._bankRepository);

  @override
  Future<void> call({String? params}) async {
    await _bankRepository.markAsPrimaryBankCard(params!);
  }
}
