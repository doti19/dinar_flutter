import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/authentication_repository.dart';

class SignInUseCase implements UseCase<DataState<void>, Map<String, dynamic>?> {
  final AuthenticationRepository _authenRepository;

  SignInUseCase(this._authenRepository);

  @override
  Future<DataState<void>> call({Map<String, dynamic>? params}) {
    final data = _authenRepository.signIn(params!['email'], params['password']);
    if (data is DataSuccess) {
      // _conversationRepository.connect();
    }
    return data;
  }
}
