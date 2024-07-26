import 'package:dinar/core/extensions/date_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../domain/enums/loan_reason_types.dart';

class MoreRequestInfo extends StatelessWidget {
  final int loanTenureMonths;
  final double interestRate;
  final double overdueInterestRate;
  final LoanReasonTypes loanReasonType;
  final DateTime dateLoan;
  final DateTime datePay;

  const MoreRequestInfo(
      {required this.loanTenureMonths,
      required this.interestRate,
      required this.overdueInterestRate,
      required this.loanReasonType,
      required this.dateLoan,
      required this.datePay,
      super.key});

  @override
  Widget build(BuildContext context) {
    const double widthItem = 120;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: widthItem,
                child: Text(
                  "Period:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                "$loanTenureMonths month",
                style: AppTextStyles.bold12.colorEx(AppColors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: widthItem,
                child: Text(
                  "Interest rate:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                "$interestRate% / month",
                style: AppTextStyles.bold12.colorEx(AppColors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: widthItem,
                child: Text(
                  "Overdue interest rate:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                "$overdueInterestRate% / month",
                style: AppTextStyles.bold12.colorEx(AppColors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: widthItem,
                child: Text(
                  "Reason for loan:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                loanReasonType.toStringVi(),
                style: AppTextStyles.bold12.colorEx(AppColors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: widthItem,
                child: Text(
                  "Loan date:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                dateLoan.toDMYString(),
                style: AppTextStyles.bold12.colorEx(AppColors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: widthItem,
                child: Text(
                  "Pay day:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                datePay.toDMYString(),
                style: AppTextStyles.bold12.colorEx(AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
