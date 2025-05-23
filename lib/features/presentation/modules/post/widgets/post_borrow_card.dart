import 'package:dinar/config/routes/app_routes.dart';
import 'package:dinar/core/constants/constants.dart';
import 'package:dinar/core/extensions/date_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';

// ignore: must_be_immutable
class PostBorrowCard extends StatelessWidget {
  final PostEntity post;

  PostBorrowCard({required this.post, super.key});

  final int numOfStars = 4;

  RxBool isLiked = false.obs;

  toggleIsLiked() {
    isLiked.value = !isLiked.value;
  }

  onTapPost() {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

  onTapAvatar() {
    Get.toNamed(AppRoutes.userProfile, arguments: post.user);
  }

  Widget _buildStars() {
    return Row(
      children: List.generate(
        5,
        (index) => Image.asset(
          Assets.star,
          width: 14,
          height: 14,
          color: index < numOfStars ? AppColors.yellow : AppColors.grey200,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // user
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // avatar
            // if (post.user!.avatar != null)
            //   ClipRRect(
            //     borderRadius: const BorderRadius.all(Radius.circular(50)),
            //     child: CachedNetworkImage(
            //       imageUrl: '${apiDevBaseUrl}/images/${post.user!.avatar}',
            //       fit: BoxFit.cover,
            //       width: 50,
            //       height: 50,
            //       errorWidget: (context, _, __) {
            //         return const CircleAvatar(
            //           radius: 25,
            //           backgroundImage: AssetImage(Assets.avatar2),
            //         );
            //       },
            //     ),
            //   )
            // else
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(Assets.avatar2),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: onTapPost,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name and stars
                        GestureDetector(
                          // onTap: onTapAvatar,
                          onTap: null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "${post.user!.firstName} ${post.user!.lastName}",
                                post.title!,
                                //"Phan Văn Minh",
                                style: AppTextStyles.semiBold14.colorEx(
                                  const Color.fromARGB(255, 83, 49, 49),
                                ),
                              ),
                              const SizedBox(height: 4),
                              _buildStars(),
                            ],
                          ),
                        ),
                        // days and contact button
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Tenure:",
                                  style: AppTextStyles.regular12.colorEx(
                                    AppColors.grey400,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  "${post.tenureMonths} month",
                                  style: AppTextStyles.regular12.colorEx(
                                    AppColors.grey400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            // Container(
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 15,
                            //     vertical: 5,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: AppColors.greenLight,
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   child: Text(
                            //     "Contact",
                            //     style: AppTextStyles.semiBold12.colorEx(
                            //       AppColors.green,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),

                    // content
                    const SizedBox(height: 10),
                    // loai bai dang: Vay tien
                    Row(
                      children: [
                        Text(
                          "Post type: ",
                          style: AppTextStyles.medium10,
                        ),
                        Text(
                          post.type!.getStringVi(),
                          style: AppTextStyles.bold10.colorEx(AppColors.green),
                        ),
                      ],
                    ),
                    // title
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // post.title!,
                          "Post Status: ${post.status!.toString()}",
                          // maxLines: 3,
                          style:
                              AppTextStyles.regular12.colorEx(AppColors.black),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Assets.clock,
                              width: 13,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "Expires ${post.postExpiresAt!.inSomeTime()}",
                              style: AppTextStyles.semiBold12.colorEx(
                                AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // thong tin chi tiet
                    const SizedBox(height: 10),
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 15,
                    //     vertical: 15,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.grey100,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       // Row(
                    //       //   children: [
                    //       //     SizedBox(
                    //       //       width: 115,
                    //       //       child: Text(
                    //       //         "Amount of money:",
                    //       //         style: AppTextStyles.regular12
                    //       //             .colorEx(AppColors.black),
                    //       //       ),
                    //       //     ),
                    //       //     Expanded(
                    //       //       child: Text(
                    //       //         "${post.loanReason.toString()}",
                    //       //         style: AppTextStyles.bold12
                    //       //             .colorEx(AppColors.black),
                    //       //       ),
                    //       //     ),
                    //       //   ],
                    //       // ),
                    //       // const SizedBox(height: 2),
                    //       // Row(
                    //       //   children: [
                    //       //     SizedBox(
                    //       //       width: 115,
                    //       //       child: Text(
                    //       //         "Interest rate:",
                    //       //         style: AppTextStyles.regular12
                    //       //             .colorEx(AppColors.black),
                    //       //       ),
                    //       //     ),
                    //       //     Text(
                    //       //       "${post.interestRate} % / year",
                    //       //       style: AppTextStyles.bold12
                    //       //           .colorEx(AppColors.black),
                    //       //     ),
                    //       //   ],
                    //       // ),
                    //       // const SizedBox(height: 2),
                    //       // Row(
                    //       //   children: [
                    //       //     SizedBox(
                    //       //       width: 115,
                    //       //       child: Text(
                    //       //         "Reason for loan:",
                    //       //         style: AppTextStyles.regular12
                    //       //             .colorEx(AppColors.black),
                    //       //       ),
                    //       //     ),
                    //       //     Text(
                    //       //       post.loanReasonType!.toString(),
                    //       //       style: AppTextStyles.bold12
                    //       //           .colorEx(AppColors.black),
                    //       //     ),
                    //       //   ],
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.clock,
                              width: 13,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              post.createdAt!.getTimeAgo(),
                              style: AppTextStyles.regular10.colorEx(
                                AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Assets.user,
                              width: 13,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "${post.bids!.length} ${post.bids!.length == 1 ? 'bid' : 'bids'}",
                              style: AppTextStyles.regular10.colorEx(
                                AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                          child: Obx(
                            () => IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: Icon(
                                isLiked.value
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_outlined,
                                size: 25,
                              ),
                              color: isLiked.value
                                  ? AppColors.yellow
                                  : AppColors.grey400,
                              onPressed: () {
                                toggleIsLiked();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: AppColors.grey200,
          thickness: 1,
          height: 30,
        )
      ],
    );
  }
}
