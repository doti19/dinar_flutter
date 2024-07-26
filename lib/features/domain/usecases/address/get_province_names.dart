import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/provinces_repository.dart';

class GetProvinceNamesUseCase
    implements UseCaseSync<DataState<List<String>>, void> {
  final ProvincesRepository _provincesRepository;

  GetProvinceNamesUseCase(this._provincesRepository);

  @override
  DataState<List<String>> call({void params}) {
    return _provincesRepository.getProvinceNames();
  }
}
