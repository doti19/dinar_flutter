import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/date_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/global_widgets/base_textfield.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/detail/dialog_cancel.dart';
import 'package:dinar/features/presentation/modules/create_post/widgets/base_row_text_dropdown.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/bid_list_screen.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/description_card.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:get/get.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:dinar/features/presentation/modules/post_detail/post_detail_controller.dart';
import 'package:heroicons/heroicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../domain/enums/post_type.dart';
import '../../../global_widgets/carousel_ad.dart';
import '../widgets/info_card.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({
    super.key,
  });

  final PostDetailController controller = Get.find<PostDetailController>();
  final SlidingUpPanelController panelController = SlidingUpPanelController();
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _interestRateFocusNode = FocusNode();
  final FocusNode _tenureFocusNode = FocusNode();
  void bidForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Form(
            key: controller.bidInCashFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Add Bid',
                  style: AppTextStyles.bold16.colorEx(AppColors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                BaseTextField(
                  focusNode: _amountFocusNode,
                  nexFocusNode: _interestRateFocusNode,
                  maxLines: 1,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  labelText: 'Desired amount (ETB)',
                  hintText: "Enter the desired amount",
                  controller: controller.amountTextController,
                  onSaved: (value) {
                    controller.amount = double.parse(value!.trim());
                  },
                  validator: (value) => (value!.trim().isNotEmpty)
                      ? null
                      : 'The amount cannot be empty',
                ),
                // Bid Rate
                const SizedBox(height: 20),
                if (controller.post.type == PostTypes.inCash)
                  BaseRowTextDropdown(
                    focusNode: _interestRateFocusNode,
                    nexFocusNode: _tenureFocusNode,
                    controller: controller.interestRateTextController,
                    textInputAction: TextInputAction.next,
                    labelText: 'Desired interest rate',
                    hintText: "Enter the desired interest rate",
                    onSaved: (value) {
                      try {
                        controller.interestRate = double.parse(value!.trim());
                      } catch (e) {
                        print(e);
                      }
                    },
                    timeValue: controller.interestRateUnit.value,
                    onChangeTimeValue: controller.setInterestRateUnit,
                    validator: (value) => (value!.trim().isNotEmpty)
                        ? null
                        : 'Interest cannot be empty',
                  ),
                // Bid Tenure
                const SizedBox(height: 20),
                BaseTextField(
                  focusNode: _tenureFocusNode,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  labelText: 'Desired tenure',
                  hintText: "Enter the desired tenure",
                  controller: controller.tenureTextController,
                  onSaved: (value) {
                    controller.tenure = int.parse(value!.trim());
                  },
                  validator: (value) => (value!.trim().isNotEmpty)
                      ? null
                      : 'The tenure cannot be empty',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Go back to the previous page
                    controller.bid();
                    Get.back();
                  },
                  child: const Text('Bid'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.post.images);
    return Scaffold(
      appBar: MyAppbar(
        title: controller.post.title!,
        actions: [
          // i want to show dialog where there is a button to bid

          TextButton(
            onPressed: () {
              return bidForm(context);
            },
            child: Text(
              'Bid',
              style: AppTextStyles.bold12.colorEx(AppColors.green800),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                if (controller.post.type == PostTypes.inKind) ...[
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
                      isLocal: true,
                    ),
                  ),
                ],
                // Mô tả
                const SizedBox(height: 10),
                DescriptionCard(
                  title: "Description",
                  description: controller.post.description!,
                ),
                // lý do vay
                const SizedBox(height: 20),
                if (controller.post.type == PostTypes.inCash)
                  DescriptionCard(
                    title:
                        "Reason for loan: ${controller.post.loanReasonType!.toString()}",
                    description: controller.post.loanReason!,
                  ),

                const SizedBox(height: 100),
              ],
            ),
          ),
          SlidingUpPanelWidget(
            controlHeight: 80.0,
            // upperBound: 0.6,
            // upperBound: 0.7,

            minimumBound: 0.0,
            // panelStatus: SlidingUpPanelStatus.collapsed,
            panelController: panelController,
            anchor: 0.0,
            enableOnTap: true,
            // elevation: 5.0,
            onTap: () {
              if (SlidingUpPanelStatus.expanded == panelController.status) {
                panelController.collapse();
              } else {
                panelController.expand();
              }
            },
            child: BidsListScreen(),
          ),
        ],
      ),
    );
  }
}
