import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bank.dart';
import 'package:dinar/features/domain/entities/credit/bank_card.dart';
import 'package:dinar/features/domain/repository/bank_repository.dart';

class GetBankCardsUseCase implements UseCase<List<BankCardEntity>, void> {
  final BankRepository _bankRepository;

  GetBankCardsUseCase(this._bankRepository);

  @override
  Future<List<BankCardEntity>> call({void params}) async {
    return [
      BankCardEntity(
          bank: BankEntity(
            name: "Abissinia",
            shortName: "AIB",
            bin: "thisbin",
            code: "1234",
            id: "2001",
            logo:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQelz9TbWV_irdMk7ncyxyT5V451aYpt7Xy6Q&s",
          ),
          bankId: "001",
          branch: "Bole",
          cardNumber: "1001",
          createdAt: DateTime.now(),
          deletedAt: DateTime.now(),
          id: "001",
          isPrimary: true,
          userId: "112")
    ];

    return await _bankRepository.getBankCards().then((value) {
      if (value is DataSuccess) {
        return value.data ?? [];
      } else {
        return [];
      }
    });
  }
}
