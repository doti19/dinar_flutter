import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import '../../../../../config/values/asset_image.dart';

class ImageLogo extends StatelessWidget {
  const ImageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Image.asset(
                Assets.appLogoLight,
                width: 70.wp,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      "Welcome to",
                      style: AppTextStyles.regular14,
                    ),
                    Text("Dinar",
                        style: AppTextStyles.bold18.colorEx(
                          AppColors.green,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
