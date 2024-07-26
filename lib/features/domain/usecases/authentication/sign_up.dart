import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/authentication_repository.dart';

class SignUpUseCase
    implements UseCase<DataState<String>, Map<String, dynamic>?> {
  final AuthenticationRepository _authenRepository;

  SignUpUseCase(this._authenRepository);

  @override
  Future<DataState<String>> call({Map<String, dynamic>? params}) async {
    final data = await _authenRepository.signUp(
        params!['email'],
        params['password'],
        params['confirmPassword'],
        params['firstName'],
        params['lastName'],
        params['phone']);
    if (data is DataSuccess) {
      // _conversationRepository.connect();
    }
    return data;
  }
}
