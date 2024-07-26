import 'package:dinar/features/domain/entities/credit/user.dart';
import 'package:dinar/features/domain/usecases/user/get_profile.dart';
import 'package:dinar/features/domain/usecases/authentication/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/config/routes/app_routes.dart';
import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/features/domain/usecases/authentication/sign_out.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../di/injection_container.dart';

class AccountController extends GetxController {
  bool isIdentity = true;
  RxBool isLoadingLogout = false.obs;
  int servicePack = 1;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  GetProfileUseCase get _getProfileUseCase => sl<GetProfileUseCase>();
  Rxn<UserEntity> me = Rxn<UserEntity>(null);

  Future<void> getProfile() async {
    print('heya ${me.value ?? 'no avatar'}');
    me.value = await _getProfileUseCase();
    print('heya ${me.value!.avatar}');
    changeServicePack(++servicePack);
  }

  navigateToProfile() {
    Get.toNamed(AppRoutes.userProfile, arguments: me.value);
  }

  void changeServicePack(int value) {
    servicePack = value;
    update();
  }

  void navToPurchase() {
    Get.toNamed(AppRoutes.purchase);
  }

  Future<void> handleSignOut() async {
    try {
      isLoadingLogout.value = true;
      SignOutUseCase signOutUseCase = sl<SignOutUseCase>();
      final dataState = await signOutUseCase();
      isLoadingLogout.value = false;
      if (dataState is DataSuccess) {
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar(
          'Success',
          'Signed out successfully',
          backgroundColor: AppColors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Logout failed',
          (dataState as DataFailed).error.toString(),
          backgroundColor: AppColors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Logout failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoadingLogout.value = false;
    }
  }
}
