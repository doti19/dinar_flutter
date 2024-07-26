import 'dart:io';

import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/user.dart';
import 'package:dinar/features/domain/repository/authentication_repository.dart';
import 'package:dinar/features/domain/repository/user_repository.dart';

class UpdateProfileUseCase implements UseCase<DataState<void>, File?> {
  final AuthenticationRepository _authenRepository;

  UpdateProfileUseCase(this._authenRepository);

  @override
  Future<DataState<void>> call({File? params}) async {
    return await _authenRepository.updateProfile(params);
  }
}

// class UpdateProfileData {
//   // final String? firstName;
//   // final String? lastName;
//   final String? email;
//   final String? avatar;
//   // final String? gender;
//   // final String? dob;
//   // final String? streetAddress
// }
