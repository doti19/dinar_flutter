import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/domain/enums/loan_reason_types.dart';
import 'package:dinar/features/presentation/modules/create_post/widgets/base_row_text_dropdown.dart';
import 'package:dinar/features/presentation/modules/create_request/create_request_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/base_dropdown_button.dart';
import '../../../global_widgets/base_textfield.dart';

class LoanInfoForm extends StatelessWidget {
  final bool isvisible;

  LoanInfoForm({required this.isvisible, required this.controller, super.key});

  final CreateRequestController controller;

  final FocusNode _discriptionFocusNode = FocusNode();
  final FocusNode _moneyFocusNode = FocusNode();
  final FocusNode _interestFocusNode = FocusNode();
  final FocusNode _overInterestFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _loanReasonFocusNode = FocusNode();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description of request",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BaseTextField(
              minLines: 3,
              maxLines: 10,
              maxLength: 1000,
              focusNode: _discriptionFocusNode,
              nexFocusNode: _moneyFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: controller.discriptionTextController,
              labelText: 'Describe the loan request',
              hintText: 'Describe the loan request',
              onSaved: (value) {
                controller.discription = value!.trim();
              },
              validator: (value) => (value!.trim().isNotEmpty)
                  ? null
                  : 'The request cannot be empty'.tr,
            ),
            const SizedBox(height: 5),
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
              controller: controller.loanAmountTextController,
              labelText: 'Amount to borrow (ETB)',
              hintText: "Enter the desired amount",
              onSaved: (value) {
                try {
                  controller.loanAmount = double.parse(value!.trim());
                } catch (e) {
                  controller.tenureMonths = 0;
                }
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
              nexFocusNode: _overInterestFocusNode,
              textInputAction: TextInputAction.next,
              labelText: 'Desired interest rate',
              hintText: "Enter the desired interest rate",
              controller: controller.interestRateTextController,
              onSaved: (value) {
                try {
                  controller.interestRate = double.parse(value!.trim());
                } catch (e) {
                  controller.tenureMonths = 0;
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
              focusNode: _overInterestFocusNode,
              nexFocusNode: _timeFocusNode,
              textInputAction: TextInputAction.next,
              labelText: 'Overdue interest rate',
              hintText: "Enter the overdue interest rate",
              controller: controller.overdueInterestRateTextController,
              onSaved: (value) {
                try {
                  controller.overdueInterestRate = double.parse(value!.trim());
                } catch (e) {
                  controller.tenureMonths = 0;
                }
              },
              timeValue: controller.timeValue.value,
              onChangeTimeValue: controller.setTimeValue,
              validator: (value) => (value!.trim().isNotEmpty)
                  ? null
                  : 'Overdue interest cannot be empty'.tr,
            ),
            const SizedBox(height: 10),
            Text(
              "Period",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BaseRowTextDropdown(
              focusNode: _timeFocusNode,
              nexFocusNode: _loanReasonFocusNode,
              textInputAction: TextInputAction.done,
              labelText: 'Desired term',
              hintText: "Enter the desired term",
              controller: controller.tenureMonthsTextController,
              onSaved: (value) {
                try {
                  controller.tenureMonths = int.parse(value!.trim());
                } catch (e) {
                  controller.tenureMonths = 0;
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
              value: controller.loanReasonType.value,
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
              focusNode: _loanReasonFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: controller.loanReasonTextController,
              labelText: 'Describe the reason for the loan',
              hintText: 'Describe the reason for the loan',
              onSaved: (value) {
                controller.loanReason = value!.trim();
              },
              validator: (value) => (value!.trim().isNotEmpty)
                  ? null
                  : 'Reason cannot be empty'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
