import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';

class LoanAmountCard extends StatelessWidget {
  final String? contractId;
  final double loanAmount;
  final double interestAmount;
  final double serviceCharge;

  const LoanAmountCard({
    this.contractId,
    required this.loanAmount,
    required this.interestAmount,
    required this.serviceCharge,
    super.key,
  });

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
          if (contractId != null)
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: widthItem,
                      child: Text(
                        "Contract Code:",
                        style: AppTextStyles.regular12.colorEx(AppColors.black),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        contractId!,
                        style: AppTextStyles.bold12.colorEx(AppColors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          Row(
            children: [
              SizedBox(
                width: widthItem,
                child: Text(
                  "Amount to borrow:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                "${loanAmount.toInt().formatNumberWithCommas} Birr",
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
                  "Interest received:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                "${interestAmount.toInt().formatNumberWithCommas} Birr",
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
                  "Service charge:",
                  style: AppTextStyles.regular12.colorEx(AppColors.black),
                ),
              ),
              Text(
                "${serviceCharge.toInt().formatNumberWithCommas} Birr",
                style: AppTextStyles.bold12.colorEx(AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
