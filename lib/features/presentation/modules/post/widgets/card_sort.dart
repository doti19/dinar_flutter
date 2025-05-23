import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../config/values/asset_image.dart';

class CardSort extends StatelessWidget {
  const CardSort({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Latest",
            style: AppTextStyles.bold14,
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              Assets.slider,
              height: 25,
              width: 25,
            ),
          )
        ],
      ),
    );
  }
}
