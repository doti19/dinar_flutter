import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/config/values/asset_image.dart';
import 'package:dinar/core/extensions/date_ex.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/info_row.dart';
import 'package:flutter/widgets.dart';

class BidCard extends StatelessWidget {
  final BidEntity bid;
  const BidCard({required this.bid, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bid.type == PostTypes.inCash)
            InfoRow(
              title: "Amount of money: ",
              value:
                  // ? "${bid.loanAmount!.toInt().formatNumberWithCommas} ETB"
                  "${bid.amount!.toInt().formatNumberWithCommas} Birr",
            ),
          const SizedBox(height: 5),
          InfoRow(
            title: "Tenure Months: ",
            value: "${bid.tenureMonths!} month ",
          ),
          const SizedBox(height: 5),
          if (bid.type == PostTypes.inCash)
            InfoRow(
              title: "Interest rate: ",
              value:
                  "${bid.interestRate!.interest}% / ${bid.interestRate!.unit.toString()}",
            ),
          const SizedBox(height: 5),
          Text(
            // post.title!,
            "Bid Status: ${bid.status!.toString()}",
            // maxLines: 3,
            style: AppTextStyles.regular12.colorEx(AppColors.black),
          ),
          // if (bid.type == PostTypes.inKind)
          //   InfoRow(
          //     title: "Reason for loan: ",
          //     // value: bid.loanReasonType!.toStringVi(),
          //     value: "some data for the time being",
          //   ),
          if (bid.type == PostTypes.inCash)
            Row(
              children: [
                Image.asset(
                  Assets.clock,
                  width: 16,
                ),
                const SizedBox(width: 2),
                Text(
                  "${bid.createdAt!.getTimeAgo()}",
                  style: AppTextStyles.regular12.colorEx(
                    AppColors.grey400,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
