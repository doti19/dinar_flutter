import 'package:dinar/features/presentation/modules/create_post/widgets/in_cash_form.dart';
import 'package:dinar/features/presentation/modules/create_post/widgets/in_kind_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:dinar/features/presentation/global_widgets/base_card.dart';
import 'package:dinar/features/presentation/modules/create_post/widgets/choose_lending_card.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/my_appbar.dart';
import '../widgets/post_info_card.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    controller.isLoading.value = false;
    return Scaffold(
      appBar: MyAppbar(
        title: 'Create Post'.tr,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // choose is lease
              BaseCard(
                title: "Select Type",
                isvisible: true,
                child: ChooseLendingCard(),
              ),
              // Thong tin bai dang
              BaseCard(
                title: "information",
                isvisible: true,
                child: PostInfoCard(),
              ),
              Obx(
                () => InCashForm(
                  isvisible: controller.isInCash.value,
                ),
              ),
              Obx(() => InKindForm(
                    isvisible: !controller.isInCash.value,
                    // isVisible: true,
                  )),
              // dang bai ============================================
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          print('fkri ${controller.isInCash.value}');
                          controller.createPost(
                              hasImages: controller.isInCash.value);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(color: AppColors.white),
                    elevation: 10,
                    minimumSize: Size(100.wp, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Post'.tr,
                          style: AppTextStyles.bold14.colorEx(AppColors.white),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
