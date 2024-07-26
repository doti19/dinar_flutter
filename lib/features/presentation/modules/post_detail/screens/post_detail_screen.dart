import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/date_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/description_card.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:dinar/features/presentation/modules/post_detail/post_detail_controller.dart';
import 'package:heroicons/heroicons.dart';

import '../../../../domain/enums/post_type.dart';
import '../../../global_widgets/carousel_ad.dart';
import '../widgets/info_card.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key});

  final PostDetailController controller = Get.find<PostDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: controller.post.title!),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserCard(
              name: controller.post.user!.fullName,
              isLiked: controller.isLiked,
              onLike: controller.toggleIsLiked,
              numOfStars: controller.numOfStars,
              avatar: controller.post.user!.avatar,
              navToUserProfile: controller.navToUserProfile,
              onContact: () {},
            ),
            // Loai bai dang
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Post type: ",
                  style: AppTextStyles.regular12.colorEx(AppColors.grey500),
                ),
                const SizedBox(width: 2),
                Text(
                  controller.post.type!.getStringVi(),
                  style: AppTextStyles.bold12.colorEx(AppColors.green),
                ),
              ],
            ),
            // time created
            const SizedBox(height: 10),
            Row(
              children: [
                const HeroIcon(
                  HeroIcons.clock,
                  size: 14,
                  color: AppColors.grey500,
                ),
                const SizedBox(width: 5),
                Text(
                  controller.post.createdAt!.getTimeAgoVi(),
                  style: AppTextStyles.regular10.colorEx(AppColors.grey500),
                ),
              ],
            ),
            // Tieu de
            const SizedBox(height: 10),
            Text(
              controller.post.title!,
              style: AppTextStyles.regular14.colorEx(AppColors.black),
            ),
            // thong tin
            const SizedBox(height: 15),
            InfoCard(post: controller.post),
            // hinh anh
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Image",
                style: AppTextStyles.bold14.colorEx(AppColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselAd(
                imgList: controller.post.images ?? [],
                aspectRatio: 1.9,
                indicatorSize: 8,
              ),
            ),
            // Mô tả
            const SizedBox(height: 10),
            DescriptionCard(
              title: "Describe",
              description: controller.post.description!,
            ),
            // lý do vay
            const SizedBox(height: 20),
            if (controller.post.type == PostTypes.inCash)
              DescriptionCard(
                title: controller.post.type == PostTypes.inKind
                    ? "Reason for loan"
                    : "Reason for loan",
                description: controller.post.loanReason!,
              ),
            // Bid Amount
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            // Bid Rate
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Interest Rate (%)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            // Bid Tenure
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Tenure (months)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            // Bid Button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Go back to the previous page
                Get.back();
              },
              child: Text('Bid'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
