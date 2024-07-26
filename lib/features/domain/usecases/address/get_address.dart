import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/provinces_repository.dart';
import '../../../data/models/nhagiare/post/address.dart';
import '../../entities/nhagiare/posts/address.dart';

class GetAddressUseCase
    implements UseCaseSync<DataState<String>, AddressModel> {
  final ProvincesRepository _provincesRepository;

  GetAddressUseCase(this._provincesRepository);

  @override
  DataState<String> call({AddressEntity? params}) {
    return _provincesRepository.getFullAddress(
      params!.country,
      params.streetAddress,
      params.city,
      params.stateProvince,
      params.streetAddress2!,
    );
  }
}
