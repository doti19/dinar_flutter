import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/authentication_repository.dart';

class SignOutUseCase implements UseCase<DataState<void>, void> {
  final AuthenticationRepository _authenRepository;

  SignOutUseCase(this._authenRepository);

  @override
  Future<DataState<void>> call({void params}) {
    return _authenRepository.signOut();
  }
}
