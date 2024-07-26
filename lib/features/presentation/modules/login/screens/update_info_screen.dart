import 'package:dinar/features/presentation/modules/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/modules/login/widgets/dropdown_with_title.dart';
import 'package:dinar/features/presentation/modules/login/widgets/image_avatar_picker.dart';
import 'package:dinar/features/presentation/modules/login/widgets/text_field_with_title.dart';
import '../../../../../config/routes/app_routes.dart';
import '../login_controller.dart';
import '../../../global_widgets/my_appbar.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final LoginController controller = Get.find<LoginController>();
  final AccountController accController = Get.find();
  //get personal data, to populate the fields

  final _fnameFocusNode = FocusNode();
  final _lnameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _birthFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  @override
  void dispose() {
    _fnameFocusNode.dispose();
    _lnameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    _birthFocusNode.dispose();
    // controller.updateInfoFormKey.currentState!.dispose();
    super.dispose();
  }

  String getEmail() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    controller.emailUpdateInfoTextController.text =
        accController.me.value!.email ?? '';
    controller.lnameUpdateInfoTextController.text =
        accController.me.value!.lastName ?? '';
    controller.fnamUpdateInfoTextController.text =
        accController.me.value!.firstName ?? '';
    controller.phoneUpdateInfoTextController.text =
        accController.me.value!.phone?.substring(4) ?? '';
    controller.birthUpdateInfoTextController.text =
        accController.me.value!.dob ?? DateTime.now().toString();
    String gender = accController.me.value!.gender?.capitalizeFirst ?? '';
    controller.addressUpdateInfoTextController.text =
        accController.me.value!.address?.city ?? '';

    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppbar(title: "Update information"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: controller.updateInfoFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
// image avatar
              const ImageAvatarPicker(),
              const SizedBox(height: 12),
// text avatar
              Center(
                child: Text(
                  "Change avatar",
                  style: AppTextStyles.bold16.colorEx(AppColors.green),
                ),
              ),
// text field Ho & ten
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWithTitle(
                    titleText: "Last name",
                    hintText: "Enter your last name",
                    enable: false,
                    canTap: true,
                    keyBoardType: TextInputType.name,
                    focusNode: _lnameFocusNode,
                    nexFocusNode: _fnameFocusNode,
                    textController: controller.lnameUpdateInfoTextController,
                    weightField: 30,
                    validateFunc: (value) => (!(value == null || value == ''))
                        ? null
                        : 'Please enter your last name'.tr,
                  ),
                  TextFieldWithTitle(
                    titleText: "Name",
                    hintText: "Enter name",
                    enable: false,
                    canTap: true,
                    keyBoardType: TextInputType.name,
                    focusNode: _fnameFocusNode,
                    nexFocusNode: _phoneFocusNode,
                    textController: controller.fnamUpdateInfoTextController,
                    weightField: 52,
                    validateFunc: (value) => (!(value == null || value == ''))
                        ? null
                        : 'Please enter your name'.tr,
                  ),
                ],
              ),
// text field so dien thoai
              const SizedBox(height: 12),
              TextFieldWithTitle(
                region: "+251",
                titleText: "Phone number",
                hintText: "Enter your phone number",
                enable: false,
                canTap: true,
                keyBoardType: TextInputType.phone,
                focusNode: _phoneFocusNode,
                textController: controller.phoneUpdateInfoTextController,
                weightField: 60,
                validateFunc: (value) => (!(value == null || value == ''))
                    ? null
                    : 'Please enter your phone number'.tr,
              ),
// text field email
              const SizedBox(height: 12),
              TextFieldWithTitle(
                  titleText: "Email",
                  hintText: "Enter Your email",
                  enable: false,
                  canTap: true,
                  keyBoardType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  textController: controller.emailUpdateInfoTextController,
                  weightField: 85,
                  validateFunc: (value) {
                    return (!(value == null || value == ''))
                        ? null
                        : 'Please enter your email'.tr;
                  }),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
// text field date of birth
                  TextFieldWithTitle(
                    titleText: "Date of birth",
                    hintText: "Enter date of birth",
                    enable: false,
                    canTap: false,
                    keyBoardType: TextInputType.datetime,
                    focusNode: _birthFocusNode,
                    textController: controller.birthUpdateInfoTextController,
                    weightField: 50,
                    validateFunc: (value) {
                      return (!(value == null || value == ''))
                          ? null
                          : 'Please enter your date of birth'.tr;
                    },
                    onTap: controller.handleDatePicker,
                  ),
// drop down button gender
                  DropdownWithTitle(
                    titleText: "Sex",
                    weightField: 32,
                    value: gender != '' ? gender.obs : controller.gender,
                    onChanged: controller.changeGender,
                    isDisabled: true,
                    // onChanged: null,
                  )
                ],
              ),
// text field address
              const SizedBox(height: 12),
              TextFieldWithTitle(
                  titleText: "Address",
                  hintText: "Enter the address",
                  enable: false,
                  canTap: true,
                  keyBoardType: TextInputType.streetAddress,
                  focusNode: _addressFocusNode,
                  textController: controller.addressUpdateInfoTextController,
                  weightField: 85,
                  validateFunc: (value) {
                    return (!(value == null || value == ''))
                        ? null
                        : 'Please enter your address'.tr;
                  }),
// Button luu
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  controller.handleUpdateProfile();
                  Get.offAndToNamed(AppRoutes.bottomBar);
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
                          color: Colors.black,
                          strokeWidth: 2,
                        ))
                    : Text(
                        'Save'.tr,
                        style: AppTextStyles.bold14.colorEx(AppColors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
