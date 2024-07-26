import 'dart:io';
import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/features/domain/usecases/authentication/sign_in.dart';
import 'package:dinar/features/domain/usecases/authentication/sign_up.dart';
import 'package:dinar/features/domain/usecases/authentication/update_profile.dart';
import 'package:flutter/widgets.dart';

import '../../../../../config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dinar/core/utils/date_picker.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/service/device_service.dart';
import '../../../../di/injection_container.dart';

class LoginController extends GetxController {
  var loginEmail = TextEditingController();
  var loginPassword = TextEditingController();
  var forgotPassEmail = TextEditingController();
  var registerFirstName = TextEditingController();
  var registerLastName = TextEditingController();
  var registerPhone = TextEditingController();
  var registerEmail = TextEditingController();
  var registerPassword = TextEditingController();
  var registerRepeatPassword = TextEditingController();
  var newPassword = TextEditingController();

  // final CountdownController countdownController =
  //     CountdownController(autoStart: true);

  final GlobalKey<FormState> _registerFormGlobalKey =
      GlobalKey<FormState>(debugLabel: 'GlobalFormKey #Register');
  final GlobalKey<FormState> _loginFormGlobalKey =
      GlobalKey<FormState>(debugLabel: 'GlobalFormKey #Login');
  final GlobalKey<FormState> _forgotPassFormGlobalKey =
      GlobalKey<FormState>(debugLabel: 'GlobalFormKey #ForgotPass');
  final GlobalKey<FormState> _changePassFormKey =
      GlobalKey<FormState>(debugLabel: 'GlobalFormKey #ChangePass');
  final GlobalKey<FormState> _updateInfoFormKey =
      GlobalKey<FormState>(debugLabel: 'GlobalFormKey #UpdateInfo');

  GlobalKey<FormState> get registerFormGlobalKey => _registerFormGlobalKey;
  GlobalKey<FormState> get loginFormGlobalKey => _loginFormGlobalKey;
  GlobalKey<FormState> get forgotPassFormGlobalKey => _forgotPassFormGlobalKey;
  GlobalKey<FormState> get changePassFormKey => _changePassFormKey;
  GlobalKey<FormState> get updateInfoFormKey => _updateInfoFormKey;

  RxString loginError = RxString('');
  RxString registerError = RxString('');
  RxBool isLoading = false.obs;
  RxBool isCountDown = true.obs;
  RxBool isObscureNewPass = true.obs;
  RxBool isObscureLogin = true.obs;
  RxBool isObscureRegister = true.obs;
  RxBool isObscureRepeatPass = true.obs;
  RxBool isObscureResetPass = true.obs;
  RxBool isObscureRepeatPassReset = true.obs;
  RxBool validatorVisibility = false.obs;
  RxBool validatorSusscess = false.obs;
  RxBool validatorChangePassVisibility = true.obs;

  void handleChangePass() async {}

  void toggleNewPass() {
    isObscureNewPass.value = !isObscureNewPass.value;
  }

  void toggleRepeatPass() {
    isObscureRepeatPassReset.value = !isObscureRepeatPassReset.value;
  }

  void togglePassword() {
    isObscureLogin.value = !isObscureLogin.value;
  }

  void togglePassReg() {
    isObscureRegister.value = !isObscureRegister.value;
  }

  void toggleResetPass() {
    isObscureResetPass.value = !isObscureResetPass.value;
  }

  void toggleRepeatPassReg() {
    isObscureRepeatPass.value = !isObscureRepeatPass.value;
  }

  Future<void> handleLogin() async {
    try {
      final SignInUseCase signInUseCase = sl<SignInUseCase>();
      // validate form
      if (_loginFormGlobalKey.currentState!.validate()) {
        // show loading
        isLoading.value = true;
        // call api
        Map<String, dynamic>? params = {
          "email": loginEmail.text,
          "password": loginPassword.text,
        };

        final dataState = await signInUseCase(params: params);
        // hide loading
        isLoading.value = false;
        // if success
        if (dataState is DataSuccess) {
          Get.offAllNamed(AppRoutes.bottomBar);
          Get.snackbar(
            'Logged in successfully',
            'Welcome to Dinar',
            backgroundColor: AppColors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Login failed',
            'Email or password is incorrect',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Login failed',
        'Email or password is incorrect',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
  }

  Future<void> handleRegister() async {
    try {
      final SignUpUseCase signUpUseCase = sl<SignUpUseCase>();
      // validate form
      if (_registerFormGlobalKey.currentState!.validate()) {
        // show loading
        isLoading.value = true;
        // call api
        Map<String, dynamic>? params = {
          "firstName": registerFirstName.text,
          "lastName": registerLastName.text,
          "phone": registerPhone.text,
          "email": registerEmail.text,
          "password": registerPassword.text,
          "confirmPassword": registerRepeatPassword.text,
        };

        final dataState = await signUpUseCase(params: params);
        // hide loading
        isLoading.value = false;
        // if success
        if (dataState is DataSuccess) {
          Get.toNamed(AppRoutes.updateInfo);
          Get.snackbar(
            'Sign Up Success',
            'Please enter OTP to continue',
            backgroundColor: AppColors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'registration failed',
            (dataState as DataFailed).error.toString(),
            backgroundColor: AppColors.red800,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'registration failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
  }

  Future<void> handleUpdateProfile() async {
    Map<String, dynamic>? params = {};
    // if (emailUpdateInfoTextController.text != null &&
    //     emailUpdateInfoTextController.text.isNotEmpty) {
    //   params['email'] = emailUpdateInfoTextController.text;
    // }
    // if (imageAvatar != null) {
    //   params['avatar'] = imageAvatar;
    // }
    try {
      // final dataState = await _updateProfileUseCase(params: params);
      final UpdateProfileUseCase updateProfileUseCase =
          sl<UpdateProfileUseCase>();

      if (_updateInfoFormKey.currentState!.validate()) {
        // print('knrakeb ena gena: $params');
        isLoading.value = true;
        final dataState = await updateProfileUseCase(params: imageAvatar);
        isLoading.value = false;
        if (dataState is DataSuccess) {
          Get.snackbar(
            'Success',
            'Profile updated successfully',
            backgroundColor: AppColors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Update failed',
            (dataState as DataFailed).error.toString(),
            backgroundColor: AppColors.red,
            colorText: Colors.white,
          );
          print('harire ${(dataState as DataFailed).error.toString()}');
        }
      }
    } catch (e) {
      Get.snackbar(
        'Update failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      print('harire1 ${e.toString()}');
    }
  }

  Future<void> handleForgotPass() async {}

  void showChangePassValidator() {
    validatorChangePassVisibility.value = true;
  }

  void hideChangePassValidator() {
    validatorChangePassVisibility.value = false;
  }

  void checkCanShowValidator(String value) {
    if (value.isEmpty || validatorSusscess.value) {
      hideValidator();
    } else {
      showValidator();
    }
  }

  void showValidator() {
    validatorVisibility.value = true;
  }

  void hideValidator() {
    validatorVisibility.value = false;
  }

  /// this is add info form
  var fnamUpdateInfoTextController = TextEditingController();
  var lnameUpdateInfoTextController = TextEditingController();
  var phoneUpdateInfoTextController = TextEditingController();
  var emailUpdateInfoTextController = TextEditingController();
  var birthUpdateInfoTextController = TextEditingController();
  var genderUpdateInfoTextController = TextEditingController();
  var addressUpdateInfoTextController = TextEditingController();

  File? imageAvatar; // file image of user

  void cancelImages() {
    imageAvatar = null;
  }

  /// get image from camera
  Future<void> getImageFromCamera() async {
    final image = await DeviceService.pickImage(ImageSource.camera);
    if (image == null) return;
    imageAvatar = image;
    Get.back();
  }

  /// get image from gallery
  Future<void> getImageFromGallery() async {
    final image = await DeviceService.pickImage(ImageSource.gallery);
    if (image == null) return;
    imageAvatar = image;
    Get.back();
  }

  /// get day from date picker
  Future<void> handleDatePicker() async {
    DateTime? date = await DatePickerHelper.getDatePicker();
    if (date != null) {
      birthUpdateInfoTextController.text =
          DateFormat('dd/MM/yyyy').format(date);
    }
  }

  /// data gender
  RxString gender = "Male".obs;

  void changeGender(String? newValue) {
    gender.value = newValue!;
  }

  /// forgot password
  var emailForgotTextController = TextEditingController();
  var newPasswordTextController = TextEditingController();
  var reNewPasswordTextController = TextEditingController();

  void handleForgotPassword() {}

  void handleResetPassword() {}
}
