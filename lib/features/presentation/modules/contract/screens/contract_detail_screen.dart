import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/utils/add_months_date.dart';
import 'package:dinar/core/utils/bank_format.dart';
import 'package:dinar/features/domain/entities/credit/contract.dart';
import 'package:dinar/features/presentation/global_widgets/base_button.dart';
import 'package:dinar/features/presentation/modules/contract/contract_controler.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/credit_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/loan_amount_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/more_request_info_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/my_appbar.dart';
import '../../post_detail/widgets/description_card.dart';
import '../widgets/detail/received_amount_item.dart';

class ContractDetailScreen extends StatefulWidget {
  const ContractDetailScreen({super.key});

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  final ContractController controller = Get.find<ContractController>();

  late ContractEntity post;

  late bool isPurchase;

  final RxBool isLoading = false.obs;

  @override
  void initState() {
    var data = Get.arguments;
    post = data[0] as ContractEntity;
    isPurchase = data[1] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: "Contract details",
        actions: [
          if (isPurchase)
            TextButton(
              onPressed: () {
                controller.navToPdfScreen(post);
              },
              child: Text(
                "View PDF",
                style: AppTextStyles.regular12.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.green,
                ),
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ReceivedAmountItem(
              title: "Total amount of money the borrower will receive",
              moneyRequest: post.amount!,
            ),
            const SizedBox(height: 20),
            LoanAmountCard(
              contractId: post.id,
              loanAmount: post.amount!,
              interestAmount: 50000,
              serviceCharge: 10000,
            ),
            const SizedBox(height: 20),
            MoreRequestInfo(
              loanTenureMonths: post.tenureInMonths!,
              interestRate: post.interestRate!,
              overdueInterestRate: post.overdueInterestRate!,
              loanReasonType: post.loanReasonType!,
              dateLoan: post.createdAt!,
              datePay: AddMonthDate.addMonthsToDateTime(
                  post.createdAt!, post.tenureInMonths!),
            ),
            const SizedBox(height: 20),
            UserCard(
              title: "Lender",
              name: post.lender!.fullName,
              avatar: post.lender!.avatar!,
              navToProfile: () => controller.navToProfile(post.lender!),
            ),
            const SizedBox(height: 20),
            CreditCard(
              buttonText: "Copy",
              bankName: post.lenderBankCard!.bank!.shortName,
              bankNumber:
                  BankFormat.formatCardNumber(post.lenderBankCard!.cardNumber!),
              logoBank: post.lenderBankCard!.bank!.logo,
              hanleChooseCard: () {
                controller.copyToClipboard(post.lenderBankCard!.cardNumber!);
              },
            ),
            const SizedBox(height: 20),
            UserCard(
              title: "Receiver",
              name: post.borrower!.fullName,
              avatar: post.borrower!.avatar!,
              navToProfile: () => controller.navToProfile(post.borrower!),
            ),
            const SizedBox(height: 20),
            CreditCard(
              bankName: post.borrowerBankCard!.bank!.shortName,
              bankNumber: BankFormat.formatCardNumber(
                  post.borrowerBankCard!.cardNumber!),
              logoBank: post.borrowerBankCard!.bank!.logo,
              hanleChooseCard: () {
                controller.copyToClipboard(post.borrowerBankCard!.cardNumber!);
              },
            ),
            const SizedBox(height: 20),
            DescriptionCard(
              title: "Describe the reason for the loan",
              description: post.loanReason!,
            ),
            const SizedBox(height: 20),
            if (!isPurchase)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     BaseButton(
              //       title: "Từ chối",
              //       colorButton: AppColors.red,
              //       width: 43.wp,
              //       isLoading: isLoading,
              //       onClick: () {
              //         Get.back();
              //       },
              //     ),
              //     BaseButton(
              //       title: "Thanh toán",
              //       width: 43.wp,
              //       isLoading: isLoading,
              //       onClick: () async => {
              //         //await controller.payContractFee(post),
              //       },
              //     ),
              //   ],
              // )

              BaseButton(
                title: "View PDF version",
                width: 100.wp,
                isLoading: isLoading,
                onClick: () {
                  controller.navToPdfScreen(post);
                },
              ),
          ],
        ),
      ),
    );
  }
}
