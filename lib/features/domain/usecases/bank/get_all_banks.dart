import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bank.dart';
import 'package:dinar/features/domain/repository/bank_repository.dart';
import '../../../../core/resources/pair.dart';

class GetAllbankUseCase
    implements UseCase<Pair<int, List<BankEntity>>, Pair<String, int>> {
  final BankRepository _bankRepository;

  GetAllbankUseCase(this._bankRepository);

  @override
  Future<Pair<int, List<BankEntity>>> call({Pair<String, int>? params}) async {
    if (params == null) {
      // return Pair(0, []);
    }
    return Pair(1, [
      BankEntity(
          id: '001',
          name: 'sam',
          code: "441",
          bin: "fdgfdg",
          shortName: "dg",
          logo:
              "https://img.freepik.com/free-vector/bank-building-with-cityscape_1284-52265.jpg")
    ]);
    // return await _bankRepository
    //     .searchBanks(params.first, params.second)
    //     .then((value) {
    //   if (value is DataSuccess) {
    //     return value.data ?? Pair(0, []);
    //   } else {
    //     return Pair(0, []);
    //   }
    // });
  }
}
