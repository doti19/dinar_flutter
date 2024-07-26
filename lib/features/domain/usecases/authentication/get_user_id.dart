import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/authentication_repository.dart';

class GetUserIdUseCase implements UseCase<String?, void> {
  final AuthenticationRepository _authenRepository;
  GetUserIdUseCase(this._authenRepository);

  @override
  Future<String?> call({void params}) async {
    final userId = _authenRepository.getUserId();
    if (userId is DataSuccess) {
      return userId.data!;
    } else {
      return null;
    }
  }
}
