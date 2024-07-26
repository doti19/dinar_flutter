import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bank_card.dart';
import 'package:dinar/features/domain/repository/bank_repository.dart';

class GetPrimaryBankCardUseCase implements UseCase<BankCardEntity?, void> {
  final BankRepository _bankRepository;

  GetPrimaryBankCardUseCase(this._bankRepository);

  @override
  Future<BankCardEntity?> call({void params}) async {
    return await _bankRepository.getPrimaryBankCard().then((value) {
      if (value is DataSuccess) {
        return value.data!;
      } else {
        return null;
      }
    });
  }
}
