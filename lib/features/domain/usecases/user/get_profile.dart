import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/user.dart';
import '../../repository/user_repository.dart';

class GetProfileUseCase implements UseCase<UserEntity?, void> {
  final UserRepository _userRepository;

  GetProfileUseCase(this._userRepository);

  @override
  Future<UserEntity?> call({void params}) async {
    return await _userRepository.getProfile().then((value) {
      if (value is DataSuccess) {
        return value.data!;
      } else {
        return null;
      }
    });
  }
}
