import 'package:dinar/config/routes/app_routes.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/features/presentation/modules/home/widgets/border_image_button.dart';
import 'package:dinar/features/presentation/modules/home/widgets/util_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/features/presentation/modules/home/widgets/home_appbar.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/entities/nhagiare/blog/blog.dart';
import '../home_controller.dart';
import '../../../global_widgets/carousel_ad.dart';
import '../widgets/blog_card.dart';
import '../widgets/load_limit_card.dart';
import '../widgets/report_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Appbar
              HomeAppbar(),
              // CarouselAd
              const SizedBox(height: 20),
              LoadLimitCard(),
              // loan limit
              const SizedBox(height: 15),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Statistical",
                      style: AppTextStyles.bold14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const ReportCard(),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BorderImageButton(
                    title: "Borrow now",
                    image: Assets.borrow,
                    onTap: () {
                      Get.toNamed(AppRoutes.createPost);
                    },
                  ),
                  BorderImageButton(
                    title: "Lend now",
                    image: Assets.creditor,
                    onTap: () {
                      controller.goToPostScreen();
                    },
                  ),
                ],
              ),

              // quang cao
              const SizedBox(height: 15),
              CarouselAd(
                imgList: controller.imgList,
                aspectRatio: 2.59,
                indicatorSize: 6,
                isLocal: false,
              ),

              // text tin tuc
              const SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 8),
              //       child: Text(
              //         "News",
              //         style: AppTextStyles.bold14,
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         Get.toNamed(AppRoutes.blog);
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.only(right: 8),
              //         child: Text(
              //           "Add >",
              //           style: AppTextStyles.light12,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // // tin tuc
              // const SizedBox(height: 10),
              // Container(
              //   width: 100.wp,
              //   constraints: BoxConstraints(maxHeight: 25.hp),
              //   child: FutureBuilder<List<BlogEntity>>(
              //     future: controller.getBlogs(),
              //     builder: (context, snapShot) {
              //       if (!snapShot.hasData) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else {
              //         List<BlogEntity> data = snapShot.data!;
              //         return ListView.separated(
              //           shrinkWrap: true,
              //           itemCount: data.length,
              //           scrollDirection: Axis.horizontal,
              //           separatorBuilder: (BuildContext context, int index) =>
              //               const SizedBox(
              //             width: 10,
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             return BlogCard(
              //               key: UniqueKey(),
              //               blog: data[index],
              //             );
              //           },
              //         );
              //       }
              //     },
              //   ),
              // ),

              // cac tien ich khac
              const SizedBox(height: 15),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Other amenities",
                      style: AppTextStyles.bold14,
                    ),
                  ),
                ],
              ),

              // cards
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UtilCard(
                      title: "Calculate interest ",
                      image: Assets.financialProfit,
                      onTap: () {},
                    ),
                    UtilCard(
                      title: "History of education",
                      image: Assets.history,
                      onTap: () {},
                    ),
                    UtilCard(
                      title: "Report",
                      image: Assets.schedule,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
