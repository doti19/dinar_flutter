import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/authentication_repository.dart';

class CheckTokenUseCase implements UseCase<DataState<bool>, void> {
  final AuthenticationRepository _authenRepository;

  // final ConversationRepository _conversationRepository;
  CheckTokenUseCase(this._authenRepository);

  @override
  Future<DataState<bool>> call({void params}) async {
    final result = await _authenRepository.refreshNewAccessToken();
    if (result is DataSuccess) {
      print('CheckTokenUseCase: ${result.data}');
      // _conversationRepository.connect();
      return const DataSuccess(true);
    }
    print('CheckTokenUseCase: ${result}');

    return const DataSuccess(false);
  }
}
