import 'package:dinar/config/routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dinar/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/global_widgets/loading_component.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:dinar/features/presentation/global_widgets/not_identity_card.dart';
import 'package:dinar/features/presentation/modules/account/account_controller.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/values/asset_image.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AccountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.servicePack = 1;

    return Scaffold(
      appBar: MyAppbar(
        title: "Account",
        isShowBack: false,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 25),
        //     child: Image.asset(
        //       Assets.chat,
        //       width: 25,
        //       height: 25,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: ListTile.divideTiles(
            color: AppColors.grey100,
            context: context,
            tiles: [
              // account
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                onTap: () {
                  controller.navigateToProfile();
                },
                title: controller.me.value == null
                    ? const LoadingComponent(color: AppColors.green)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                controller.me.value!.fullName,
                                style: AppTextStyles.medium16,
                              ),
                              const SizedBox(width: 2),
                              if (controller.isIdentity)
                                Image.asset(
                                  Assets.badge,
                                  height: 15,
                                  width: 15,
                                ),
                            ],
                          ),
                          if (!controller.isIdentity) const NotIdentityCard(),
                        ],
                      ),
                leading: controller.me.value != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${apiDevBaseUrl}/images/${controller.me.value!.avatar}',
                          fit: BoxFit.cover,
                          width: 36,
                          height: 36,
                          errorWidget: (context, _, __) {
                            return const CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(Assets.avatarDefault),
                            );
                          },
                        ),
                      )
                    : const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(Assets.avatarDefault),
                      ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // favorite
              // ListTile(
              //   contentPadding:
              //       const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              //   title: Text(
              //     'Đã lưu',
              //     style: AppTextStyles.medium16,
              //   ),
              //   onTap: () {},
              //   leading: const Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 5),
              //     child: Icon(
              //       Icons.favorite,
              //       color: AppColors.red,
              //       size: 25,
              //     ),
              //   ),
              //   trailing: const Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     size: 18,
              //   ),
              // ),
              // purchase
              // ListTile(
              //   contentPadding:
              //       const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              //   title: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Service pack',
              //         style: AppTextStyles.medium16,
              //       ),
              //       const SizedBox(height: 2),
              //       if (controller.servicePack != 0)
              //         Container(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 8, vertical: 2),
              //           decoration: BoxDecoration(
              //             color: controller.servicePack == 1
              //                 ? AppColors.green100
              //                 : controller.servicePack == 2
              //                     ? AppColors.blue100
              //                     : AppColors.red100,
              //             borderRadius: BorderRadius.circular(4),
              //           ),
              //           child: Text(
              //             controller.servicePack == 1
              //                 ? "Basic package"
              //                 : controller.servicePack == 2
              //                     ? "Professional package"
              //                     : "Business package",
              //             style: AppTextStyles.medium12
              //                 .colorEx(controller.servicePack == 1
              //                     ? AppColors.green800
              //                     : controller.servicePack == 2
              //                         ? AppColors.blue800
              //                         : AppColors.red),
              //           ),
              //         )
              //     ],
              //   ),
              //   onTap: () {
              //     // controller.navToPurchase();
              //   },
              //   leading: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 5),
              //     child: Image.asset(
              //       Assets.archive,
              //       height: 25,
              //       color: AppColors.black,
              //     ),
              //   ),
              //   trailing: const Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     size: 18,
              //   ),
              // ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Manage Posts',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.postManagement);
                },
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    Assets.chart,
                    height: 25,
                    color: AppColors.black,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // ListTile(
              //   contentPadding:
              //       const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              //   title: Text(
              //     'Manage Bids',
              //     style: AppTextStyles.medium16,
              //   ),
              //   onTap: () {
              //     Get.toNamed(AppRoutes.bidManagement);
              //   },
              //   leading: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 5),
              //     child: Image.asset(
              //       Assets.money,
              //       height: 25,
              //       color: AppColors.black,
              //     ),
              //   ),
              //   trailing: const Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     size: 18,
              //   ),
              // ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Manage bank cards',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.bank);
                },
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.credit_card,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // update info
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Update information',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.updateInfo);
                },
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.edit_outlined,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // change Password
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Change Password',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {},
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // change language
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Language',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {},
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.language_outlined,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // logout
              Obx(() => ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                    title: controller.isLoadingLogout.value
                        ? const LoadingComponent(color: AppColors.red)
                        : Text(
                            'Log out',
                            style:
                                AppTextStyles.medium16.colorEx(AppColors.red),
                          ),
                    onTap: () {
                      controller.handleSignOut();
                    },
                    leading: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.logout,
                        color: AppColors.red,
                        size: 25,
                      ),
                    ),
                  )),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
