import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/domain/enums/loan_reason_types.dart';
import 'package:dinar/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:dinar/features/presentation/modules/create_post/widgets/base_row_text_dropdown.dart';
import 'package:dinar/features/presentation/modules/create_post/widgets/picker_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/base_dropdown_button.dart';
import '../../../global_widgets/base_textfield.dart';

class InCashForm extends StatelessWidget {
  final bool isvisible;

  InCashForm({required this.isvisible, super.key});

  final CreatePostController controller = Get.find<CreatePostController>();
  final FocusNode _moneyFocusNode = FocusNode();
  final FocusNode _interestFocusNode = FocusNode();
  final FocusNode _overdueFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();

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
          key: controller.inCashFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Amount of money",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseTextField(
                focusNode: _moneyFocusNode,
                nexFocusNode: _interestFocusNode,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: controller.lendingLoanAmountTextController,
                labelText: 'Desired amount (ETB)',
                hintText: "Enter the desired amount",
                onSaved: (value) {
                  controller.lendingLoanAmount = double.parse(value!.trim());
                },
                validator: (value) => (value!.trim().isNotEmpty)
                    ? null
                    : 'The amount cannot be empty'.tr,
              ),
              const SizedBox(height: 10),
              Text(
                "Interest rate",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _interestFocusNode,
                nexFocusNode: _overdueFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Desired interest rate',
                hintText: "Enter the desired interest rate",
                controller: controller.lendingInterestRateTextController,
                onSaved: (value) {
                  try {
                    controller.lendingInterestRate =
                        double.parse(value!.trim());
                  } catch (e) {
                    print(e);
                  }
                },
                timeValue: controller.timeValue.value,
                onChangeTimeValue: controller.setTimeValue,
                validator: (value) => (value!.trim().isNotEmpty)
                    ? null
                    : 'Interest cannot be empty'.tr,
              ),
              const SizedBox(height: 10),
              Text(
                "Overdue interest rate",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _overdueFocusNode,
                nexFocusNode: _timeFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Overdue interest rate',
                hintText: "Enter the overdue interest rate",
                controller: controller.lendingOverdueInterestRateTextController,
                onSaved: (value) {
                  try {
                    controller.lendingOverdueInterestRate =
                        double.parse(value!.trim());
                  } catch (e) {
                    print(e);
                  }
                },
                timeValue: controller.timeValue.value,
                onChangeTimeValue: controller.setTimeValue,
                validator: (value) => (value!.trim().isNotEmpty)
                    ? null
                    : 'Interest cannot be empty'.tr,
              ),
              const SizedBox(height: 10),
              Text(
                "Period",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _timeFocusNode,
                nexFocusNode: _timeFocusNode,
                textInputAction: TextInputAction.done,
                labelText: 'Desired term',
                hintText: "Enter the desired term",
                controller: controller.lendingTenureMonthsTextController,
                onSaved: (value) {
                  try {
                    controller.lendingTenureMonths = int.parse(value!.trim());
                  } catch (e) {
                    print(e);
                  }
                },
                timeValue: controller.timeValue.value,
                onChangeTimeValue: controller.setTimeValue,
                validator: (value) => (value!.trim().isNotEmpty)
                    ? null
                    : 'The term cannot be empty'.tr,
              ),
              const SizedBox(height: 10),
              Text(
                "Reason for loan",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseDropdownButton(
                title: "Type of loan reason",
                hint: "Select the type of loan reason",
                value: controller.borrowingLoanReasonType.value,
                items: LoanReasonTypes.toMap().entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.key,
                    child: Text(
                      entry.value,
                      overflow: TextOverflow.visible,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setLoanReason(value as LoanReasonTypes);
                  }
                },
                onSaved: (value) {
                  if (value == null) return;
                },
              ),
              const SizedBox(height: 15),
              BaseTextField(
                minLines: 3,
                maxLines: 10,
                maxLength: 1000,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: controller.borrowingLoanReasonTextController,
                labelText: 'Describe the reason for the loan',
                hintText: 'Describe the reason for the loan',
                onSaved: (value) {
                  controller.borrowingLoanReason = value!.trim();
                },
                validator: (value) => (value!.trim().isNotEmpty)
                    ? null
                    : 'Reason cannot be empty'.tr,
              ),
              const SizedBox(height: 5),
              // Text(
              //   "Image",
              //   style: AppTextStyles.bold14.colorEx(Colors.black),
              // ),
              // const SizedBox(height: 10),
              // const PickerImages(),
            ],
          ),
        ),
      ),
    );
  }
}
