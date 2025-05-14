import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/info_row.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';

class InfoCard extends StatelessWidget {
  final PostEntity post;
  const InfoCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.type == PostTypes.inCash)
            InfoRow(
              title: "Amount of money: ",
              value:
                  // ? "${post.loanAmount!.toInt().formatNumberWithCommas} ETB"
                  "${post.loanAmount!.toInt().formatNumberWithCommas} Birr ${post.maxLoanAmount != null ? '- ${post.maxLoanAmount!.toInt().formatNumberWithCommas} Birr' : ''}",
            ),
          const SizedBox(height: 5),
          InfoRow(
            title: "Tenure Months: ",
            value:
                "${post.tenureMonths!} month ${post.maxTenureMonths != null ? '- ${post.maxTenureMonths!} month' : ''}",
          ),
          const SizedBox(height: 5),
          if (post.type == PostTypes.inCash)
            InfoRow(
              title: "Interest rate: ",
              value:
                  "${post.interestRate!.interest}% / ${post.interestRate!.unit.toString()} ${post.maxInterestRate != null ? '- ${post.maxInterestRate!.interest}% / ${post.maxInterestRate!.unit.toString()}' : ''} ",
            ),
          const SizedBox(height: 5),
          if (post.type == PostTypes.inKind)
            InfoRow(
              title: "Reason for loan: ",
              // value: post.loanReasonType!.toStringVi(),
              value: "some data for the time being",
            ),
          if (post.type == PostTypes.inCash)
            InfoRow(
              title: "overdue: ",
              value:
                  "${post.overdueInterestRate!.interest}% / ${post.overdueInterestRate!.unit.toString()} ${post.maxOverdueInterestRate != null ? '- ${post.maxOverdueInterestRate!.interest}% / month' : ''}",
            ),
        ],
      ),
    );
  }
}
