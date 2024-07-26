import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:dinar/config/routes/app_routes.dart';
import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/entities/credit/transaction.dart';
import '../../../../domain/enums/transaction_status.dart';

class PurchasePaymentResultScreen extends StatefulWidget {
  final FlutterZaloPayStatus status;
  const PurchasePaymentResultScreen(this.status, {super.key});

  @override
  State<PurchasePaymentResultScreen> createState() =>
      _PurchasePaymentResultScreenState();
}

class _PurchasePaymentResultScreenState
    extends State<PurchasePaymentResultScreen> {
  Widget customText(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              text1,
              style: AppTextStyles.regular14.colorEx(AppColors.grey700),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              text2,
              style: AppTextStyles.semiBold14,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isBack = Get.arguments is String == false;
    return Scaffold(
      appBar: MyAppbar(
        title: 'Transaction results',
        isShowBack: isBack,
      ),
      backgroundColor: AppColors.white,
      body: FutureBuilder<TransactionEntity?>(
          future: Future.value(const TransactionEntity()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              Get.dialog(Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.red,
                      size: 48.0,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "Transaction does not exist",
                      style: AppTextStyles.bold18,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "The transaction does not exist or has been canceled. Please try again later.",
                      style: AppTextStyles.regular14,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Come back"),
                    ),
                  ],
                ),
              ));
            }
            TransactionEntity transaction = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 20),
                            margin: const EdgeInsets.only(
                                top: 8.0, left: 20.0, right: 20.0),
                            child: Image.asset(
                                widget.status == FlutterZaloPayStatus.success
                                    ? Assets.purchaseSuccess
                                    : Assets.purchaseFailed),
                          ),
                          Text(
                            'Transaction${transaction.status == TransactionStatus.success ? "" : " Are not"} success',
                            style: AppTextStyles.bold18,
                          ),
                          Text(
                            "${200000}đ",
                            style: AppTextStyles.bold18.colorEx(
                              transaction.status == TransactionStatus.success
                                  ? AppColors.green
                                  : AppColors.red,
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: AppColors.grey100,
                                width: 1,
                              ),
                            ),
                            child: const Column(
                              children: [
                                // customText("Mã giao dịch", transaction.id),
                                // customText("Thời gian giao dịch",
                                //     transaction.timestamp.toHMDMYString()),
                                // customText("Loại giao dịch",
                                //     "Mua ${transaction.package?.name ?? "Gói Dịch Vụ"} ${transaction.numOfSubscriptionMonth} tháng"),
                                // customText(
                                //     "Ngày bắt đầu",
                                //     transaction.subscription?.startingDate
                                //             .toHMDMYString() ??
                                //         ""),
                                // customText(
                                //     "Ngày kết thúc",
                                //     transaction.subscription?.expirationDate
                                //             .toHMDMYString() ??
                                //         ""),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.info,
                                      color: AppColors.yellow,
                                      size: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " You can review transactions in the transaction history. If you need help, you can contact us ",
                                    style: AppTextStyles.light14
                                        .colorEx(AppColors.black),
                                  ),
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: () {
                                        launchUrl(
                                            Uri.parse("tel://0914281719"));
                                      },
                                      child: Text(
                                        "0914281719",
                                        style: AppTextStyles.semiBold14
                                            .colorEx(AppColors.yellow),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                      text: " or ",
                                      style: AppTextStyles.light14
                                          .colorEx(AppColors.black)),
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            "mailto://saminassaminas@gmail.com"));
                                      },
                                      child: Text(
                                        "saminassaminas@gmail.com",
                                        style: AppTextStyles.semiBold14
                                            .colorEx(AppColors.yellow),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                        ),
                        onPressed: () {
                          if (isBack) {
                            Get.back();
                          } else {
                            Get.offAllNamed(AppRoutes.bottomBar);
                          }
                        },
                        child: Text(
                          isBack ? "Come back" : "Home page",
                          style: AppTextStyles.bold14.colorEx(AppColors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
