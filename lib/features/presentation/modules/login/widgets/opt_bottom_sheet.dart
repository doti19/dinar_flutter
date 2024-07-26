import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../../config/routes/app_routes.dart';
import '../login_controller.dart';

class OTPBottomSheet extends StatelessWidget {
  OTPBottomSheet(this.controller, {super.key});
  final LoginController controller;
  final int timeCouter = 180;
  final OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 70.hp,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const SizedBox(height: 50),
            // text xac nhan otp
            Text(
              "Confirm OTP code",
              style: AppTextStyles.bold20.colorEx(AppColors.green),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "A 6-digit verification code has been sent to your email",
                style: AppTextStyles.regular14.colorEx(AppColors.grey700),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              "Enter the code to continue",
              style: AppTextStyles.regular14.colorEx(AppColors.grey700),
              textAlign: TextAlign.center,
            ),
// opt
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
              child: OTPTextField(
                length: 6,
                controller: otpController,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 52,
                style: AppTextStyles.bold24.colorEx(AppColors.green)!,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  Get.toNamed(AppRoutes.resetPassword);
                },
              ),
            ),
// text
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'You did not receive the code? ',
                  style: AppTextStyles.regular14.colorEx(AppColors.grey700),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Send to ',
                      style: AppTextStyles.regular14.colorEx(AppColors.orange),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '(${timeCouter}s)',
                          style: AppTextStyles.regular14
                              .colorEx(AppColors.grey700),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
