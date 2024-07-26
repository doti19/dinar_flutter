import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/utils/add_months_date.dart';
import 'package:dinar/core/utils/bank_format.dart';
import 'package:dinar/features/domain/entities/credit/loan_request.dart';
import 'package:dinar/features/presentation/global_widgets/base_button.dart';
import 'package:dinar/features/presentation/global_widgets/header_title.dart';
import 'package:dinar/features/presentation/modules/contract/contract_controler.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/credit_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/dialog_cancel.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/image_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/loan_amount_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/more_request_info_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/user_card.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/video_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/enums/loan_contract_request_status.dart';
import '../../../global_widgets/my_appbar.dart';
import '../../post_detail/widgets/description_card.dart';
import '../widgets/detail/received_amount_item.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  final ContractController controller = Get.find<ContractController>();

  final LoanRequestEntity post = Get.arguments as LoanRequestEntity;

  final RxBool isLoading = false.obs;

  void showCommentForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DialogCancel(
        request: post,
        handleRejectRequest: controller.rejectRequest,
      ),
    );
  }

  Rx<LoanContractRequestStatus> status = LoanContractRequestStatus.pending.obs;

  @override
  void initState() {
    status.value = post.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: "Request details",
        actions: [
          TextButton(
            onPressed: () {
              controller.reviewContract(post);
            },
            child: Text(
              "See contract",
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
              moneyRequest: post.loanAmount!,
            ),
            const SizedBox(height: 20),
            LoanAmountCard(
              loanAmount: post.loanAmount!,
              interestAmount: 50000,
              serviceCharge: 10000,
            ),
            const SizedBox(height: 20),
            MoreRequestInfo(
              loanTenureMonths: post.loanTenureMonths!,
              interestRate: post.interestRate!,
              overdueInterestRate: post.overdueInterestRate!,
              loanReasonType: post.loanReasonType!,
              dateLoan: post.createdAt!,
              datePay: AddMonthDate.addMonthsToDateTime(
                  post.createdAt!, post.loanTenureMonths!),
            ),
            const SizedBox(height: 20),
            UserCard(
              title: "Sender",
              name: post.sender!.fullName,
              avatar: post.sender!.avatar!,
              navToProfile: () => controller.navToProfile(post.sender!),
            ),
            const SizedBox(height: 20),
            CreditCard(
              bankName: post.senderBankCard!.bank!.shortName,
              bankNumber:
                  BankFormat.formatCardNumber(post.senderBankCard!.cardNumber!),
              logoBank: post.senderBankCard!.bank!.logo,
              hanleChooseCard: () {
                controller.copyToClipboard(post.senderBankCard!.cardNumber!);
              },
            ),
            const SizedBox(height: 20),
            DescriptionCard(
              title: "Description of request",
              description: post.description!,
            ),
            const SizedBox(height: 20),
            DescriptionCard(
              title: "Describe the reason for the loan",
              description: post.loanReason!,
            ),
            const SizedBox(height: 20),
            if (post.status == LoanContractRequestStatus.rejected &&
                post.rejectedReason != null)
              DescriptionCard(
                title: "Reason for canceling request",
                description: post.rejectedReason!,
              ),
            const SizedBox(height: 10),
            const HeaderTitle(title: "Portrait"),
            const SizedBox(height: 10),
            ImageCard(images: [post.portaitPhoto!]),
            const SizedBox(height: 10),
            const HeaderTitle(title: "ID photo / ID card:"),
            const SizedBox(height: 10),
            ImageCard(images: [post.idCardFrontPhoto!, post.idCardBackPhoto!]),
            if (post.videoConfirmation != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  const HeaderTitle(title: "Video demonstration:"),
                  const SizedBox(height: 10),
                  VideoCard(videoUrl: post.videoConfirmation!),
                ],
              ),
            const SizedBox(height: 20),
            Obx(
              () => controller.isConfirming.value
                  ? const Center(child: CircularProgressIndicator())
                  : status.value == LoanContractRequestStatus.pending
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BaseButton(
                              title: "Refuse",
                              colorButton: AppColors.red,
                              width: 43.wp,
                              isLoading: isLoading,
                              onClick: () {
                                showCommentForm(context);
                              },
                            ),
                            BaseButton(
                              title: "Agree",
                              width: 43.wp,
                              isLoading: isLoading,
                              onClick: () async {
                                controller.confirmRequest(post).then((value) {
                                  status.value = LoanContractRequestStatus
                                      .waitingForPayment;
                                  setState(() {});
                                });
                              },
                            ),
                          ],
                        )
                      : status.value ==
                              LoanContractRequestStatus.waitingForPayment
                          ? BaseButton(
                              title: "Pay",
                              width: 100.wp,
                              isLoading: isLoading,
                              onClick: () async {
                                await controller.payContractFee(post);
                              },
                            )
                          : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
