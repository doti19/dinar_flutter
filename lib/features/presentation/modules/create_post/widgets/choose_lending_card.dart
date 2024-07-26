import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../create_post_controller.dart';

class ChooseLendingCard extends StatelessWidget {
  ChooseLendingCard({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.setIsInCash(true);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: controller.isInCash.value != true
                    ? AppColors.greenLight
                    : AppColors.grey200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Cash",
                style: AppTextStyles.medium14.copyWith(
                  color: controller.isInCash.value != true
                      ? AppColors.green
                      : AppColors.grey600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.setIsInCash(false);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: controller.isInCash.value == true
                    ? AppColors.greenLight
                    : AppColors.grey200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "in Kind",
                style: AppTextStyles.medium14.copyWith(
                  color: controller.isInCash.value == true
                      ? AppColors.green
                      : AppColors.grey600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
