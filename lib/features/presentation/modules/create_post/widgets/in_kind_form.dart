import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/domain/enums/loan_reason_types.dart';
import 'package:dinar/features/presentation/global_widgets/base_dropdown_button.dart';
import 'package:dinar/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:dinar/features/presentation/modules/create_post/widgets/picker_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/base_textfield.dart';
import 'base_row_text_dropdown.dart';

class InKindForm extends StatelessWidget {
  final bool isvisible;

  InKindForm({required this.isvisible, super.key});

  final CreatePostController controller = Get.find<CreatePostController>();
  final FocusNode _moneyFocusNode = FocusNode();
  final FocusNode _maxMoneyFocusNode = FocusNode();
  final FocusNode _interestFocusNode = FocusNode();
  final FocusNode _maxInterestFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _maxTimeFocusNode = FocusNode();
  final FocusNode _overdueFocusNode = FocusNode();
  final FocusNode _maxOverdueFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isvisible,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Form(
          key: controller.inKindFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Loan Type",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseTextField(
                focusNode: _moneyFocusNode,
                nexFocusNode: _maxMoneyFocusNode,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: controller.loantypeControllerr,
                labelText: 'Enter the type of loan',
                hintText: "Enter the specific in-kind propery",
                onSaved: (value) {
                  try {
                    controller.lendingLoanAmount = double.parse(value!.trim());
                  } catch (e) {
                    print(e);
                  }
                },
                validator: (value) => (value!.trim().isNotEmpty)
                    ? null
                    : 'The amount cannot be empty'.tr,
              ),
              const SizedBox(height: 10),
              // BaseTextField(
              //   focusNode: _maxMoneyFocusNode,
              //   nexFocusNode: _interestFocusNode,
              //   maxLines: 1,
              //   keyboardType: TextInputType.number,
              //   textInputAction: TextInputAction.next,
              //   controller: controller.lendingMaxLoanAmountTextController,
              //   labelText: 'Maximum amount (VND)',
              //   hintText: "Enter the maximum loan amount",
              //   onSaved: (value) {
              //     try {
              //       controller.lendingMaxLoanAmount =
              //           double.parse(value!.trim());
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   validator: (value) => (value!.trim().isNotEmpty)
              //       ? null
              //       : 'The amount cannot be empty'.tr,
              // ),
              const SizedBox(height: 10),
              Text(
                "Loan Tenure ",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _interestFocusNode,
                nexFocusNode: _maxInterestFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Enter the Loan tenure',
                hintText: "",
                controller: controller.borrowingTenureMonthsTextController,
                onSaved: (value) {
                  try {
                    controller.borrowingTenureMonths = int.parse(value!.trim());
                  } catch (e) {
                    print(e);
                  }
                },
                timeValue: controller.interestRateUnit.value,
                onChangeTimeValue: controller.setInterestRateUnit,
                validator: (value) => (value!.trim().isNotEmpty)
                    ? null
                    : 'Loan Tenure cannot be empty'.tr,
              ),
              const SizedBox(height: 10),
              // BaseRowTextDropdown(
              //   focusNode: _maxInterestFocusNode,
              //   nexFocusNode: _timeFocusNode,
              //   textInputAction: TextInputAction.next,
              //   labelText: 'Maximum interest rate',
              //   hintText: "Enter the maximum interest rate",
              //   controller: controller.lendingMaxInterestRateTextController,
              //   onSaved: (value) {
              //     try {
              //       controller.lendingMaxInterestRate =
              //           double.parse(value!.trim());
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   timeValue: controller.timeValue.value,
              //   onChangeTimeValue: controller.setTimeValue,
              //   validator: (value) => (value!.trim().isNotEmpty)
              //       ? null
              //       : 'Interest cannot be empty'.tr,
              // ),
              const SizedBox(height: 10),
              // Text(
              //   "Period",
              //   style: AppTextStyles.bold14.colorEx(Colors.black),
              // ),
              // const SizedBox(height: 10),
              // BaseRowTextDropdown(
              //   focusNode: _timeFocusNode,
              //   nexFocusNode: _maxTimeFocusNode,
              //   textInputAction: TextInputAction.next,
              //   labelText: 'Minimum term',
              //   hintText: "Enter the minimum term",
              //   controller: controller.lendingTenureMonthsTextController,
              //   onSaved: (value) {
              //     try {
              //       controller.lendingTenureMonths = int.parse(value!.trim());
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   timeValue: controller.timeValue.value,
              //   onChangeTimeValue: controller.setTimeValue,
              //   validator: (value) => (value!.trim().isNotEmpty)
              //       ? null
              //       : 'The term cannot be empty'.tr,
              // ),
              const SizedBox(height: 10),
              // BaseRowTextDropdown(
              //   focusNode: _maxTimeFocusNode,
              //   nexFocusNode: _overdueFocusNode,
              //   textInputAction: TextInputAction.next,
              //   labelText: 'Maximum term',
              //   hintText: "Enter the maximum term",
              //   controller: controller.lendingMaxTenureMonthsTextController,
              //   onSaved: (value) {
              //     try {
              //       controller.lendingMaxTenureMonths =
              //           int.parse(value!.trim());
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   timeValue: controller.timeValue.value,
              //   onChangeTimeValue: controller.setTimeValue,
              //   validator: (value) => (value!.trim().isNotEmpty)
              //       ? null
              //       : 'The term cannot be empty'.tr,
              // ),
              const SizedBox(height: 10),
              // Text(
              //   "Overdue interest rate",
              //   style: AppTextStyles.bold14.colorEx(Colors.black),
              // ),
              const SizedBox(height: 10),
              // BaseRowTextDropdown(
              //   focusNode: _overdueFocusNode,
              //   nexFocusNode: _maxOverdueFocusNode,
              //   textInputAction: TextInputAction.next,
              //   labelText: 'Minimum overdue interest rate',
              //   hintText: "Enter the minimum overdue interest rate",
              //   controller: controller.lendingOverdueInterestRateTextController,
              //   onSaved: (value) {
              //     try {
              //       controller.lendingOverdueInterestRate =
              //           double.parse(value!.trim());
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   timeValue: controller.timeValue.value,
              //   onChangeTimeValue: controller.setTimeValue,
              //   validator: (value) => (value!.trim().isNotEmpty)
              //       ? null
              //       : 'Interest cannot be empty'.tr,
              // ),
              const SizedBox(height: 10),
              // BaseRowTextDropdown(
              //   focusNode: _maxOverdueFocusNode,
              //   nexFocusNode: _maxOverdueFocusNode,
              //   textInputAction: TextInputAction.done,
              //   labelText: 'Maximum overdue interest rate',
              //   hintText: "Enter the maximum overdue interest rate",
              //   controller:
              //       controller.lendingMaxOverdueInterestRateTextController,
              //   onSaved: (value) {
              //     try {
              //       controller.lendingMaxOverdueInterestRate =
              //           double.parse(value!.trim());
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   timeValue: controller.timeValue.value,
              //   onChangeTimeValue: controller.setTimeValue,
              //   validator: (value) => (value!.trim().isNotEmpty)
              //       ? null
              //       : 'Interest cannot be empty'.tr,
              // ),
              const SizedBox(height: 5),
              Text(
                "Image",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              const PickerImages(),
            ],
          ),
        ),
      ),
    );
  }
}
