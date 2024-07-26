import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../core/extensions/string_ex.dart';
import '../login_controller.dart';
import '../widgets/image_logo.dart';
import '../../../global_widgets/my_appbar.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginController controller = Get.find<LoginController>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _rePasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _rePasswordFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _cityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Register"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: controller.registerFormGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              const ImageLogo(),
              // text field email
              Obx(() => TextFormField(
                    focusNode: _firstNameFocusNode,
                    controller: controller.registerFirstName,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                      hintText: 'First Name'.tr,
                      labelText: 'Enter Your First Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      errorText: (controller.registerError.value == '')
                          ? null
                          : controller.registerError.value,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) => (value!.isAlphabetOnly)
                        ? null
                        : 'Invalid first name'.tr,
                    onTapOutside: (event) {
                      _firstNameFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_lastNameFocusNode);
                    },
                  )),
              const SizedBox(height: 15),
              Obx(() => TextFormField(
                    focusNode: _lastNameFocusNode,
                    controller: controller.registerLastName,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                      hintText: 'Last Name'.tr,
                      labelText: 'Enter Your Last Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      errorText: (controller.registerError.value == '')
                          ? null
                          : controller.registerError.value,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) =>
                        (value!.isAlphabetOnly) ? null : 'Invalid name'.tr,
                    onTapOutside: (event) {
                      _lastNameFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_phoneFocusNode);
                    },
                  )),
              const SizedBox(height: 15),
              Obx(() => TextFormField(
                    focusNode: _phoneFocusNode,
                    controller: controller.registerPhone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                      hintText: 'Phone +251...'.tr,
                      labelText: 'Enter Your Phone Number',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      errorText: (controller.registerError.value == '')
                          ? null
                          : controller.registerError.value,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) => (value!.isPhoneNumber)
                        ? null
                        : 'Invalid phone number'.tr,
                    onTapOutside: (event) {
                      _phoneFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  )),
              const SizedBox(height: 15),
              Obx(() => TextFormField(
                    focusNode: _emailFocusNode,
                    controller: controller.registerEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                      hintText: 'Email'.tr,
                      labelText: 'Enter Your Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      errorText: (controller.registerError.value == '')
                          ? null
                          : controller.registerError.value,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) =>
                        (value!.isEmail) ? null : 'Invalid email'.tr,
                    onTapOutside: (event) {
                      _emailFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  )),
              const SizedBox(height: 15),
              Obx(() => TextFormField(
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: controller.registerPassword,
                    obscureText: controller.isObscureRegister.value,
                    style: AppTextStyles.regular14,
                    autocorrect: false,
                    enableSuggestions: false,
                    onChanged: (value) {
                      controller.checkCanShowValidator(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Password'.tr,
                        labelText: 'Enter password'.tr,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            !controller.isObscureRegister.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.green,
                          ),
                          onPressed: controller.togglePassReg,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password can not be blank'.tr;
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      _passwordFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_rePasswordFocusNode);
                    },
                  )),
              const SizedBox(height: 10),
              Obx(
                () => Visibility(
                  visible: controller.validatorVisibility.value,
                  child: FlutterPwValidator(
                      controller: controller.registerPassword,
                      strings: ValidateString(),
                      minLength: 8,
                      successColor: AppColors.green,
                      failureColor: AppColors.red,
                      uppercaseCharCount: 1,
                      lowercaseCharCount: 1,
                      specialCharCount: 1,
                      numericCharCount: 1,
                      width: 400,
                      height: 180,
                      onSuccess: () {
                        controller.hideValidator();
                        controller.validatorSusscess.value = true;
                      },
                      onFail: () {
                        controller.showValidator();
                        controller.validatorSusscess.value = false;
                      }),
                ),
              ),
              const SizedBox(height: 5),
              Obx(() => TextFormField(
                    focusNode: _rePasswordFocusNode,
                    textInputAction: TextInputAction.done,
                    controller: controller.registerRepeatPassword,
                    obscureText: controller.isObscureRepeatPass.value,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                        hintText: 'Enter the password'.tr,
                        labelText: 'password'.tr,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            !controller.isObscureRepeatPass.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.green,
                          ),
                          onPressed: controller.toggleRepeatPassReg,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password can not be blank'.tr;
                      } else if (value !=
                          controller.registerRepeatPassword.text) {
                        return "password incorrect".tr;
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      _rePasswordFocusNode.unfocus();
                    },
                  )),
              const SizedBox(height: 20),
              // Button register
              Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.handleRegister();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(color: AppColors.white),
                      elevation: 10,
                      minimumSize: Size(100.wp, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ))
                        : Text(
                            'Register'.tr,
                            style:
                                AppTextStyles.bold14.colorEx(AppColors.white),
                          ),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                      onPressed: () async {
                        Get.offAll(const LoginScreen());
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                      ),
                      child: Text('Log in'.tr)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
