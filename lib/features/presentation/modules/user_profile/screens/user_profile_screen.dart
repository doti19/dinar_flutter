import 'package:dinar/core/constants/constants.dart';
import 'package:dinar/core/extensions/date_ex.dart';
import 'package:dinar/features/presentation/modules/user_profile/screens/dashboard.dart';
import 'package:dinar/features/presentation/modules/user_profile/screens/dialog_report.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:dinar/features/presentation/modules/user_profile/user_profile_controller.dart';
import 'package:dinar/features/presentation/modules/user_profile/widgets/button_follow.dart';
import 'package:dinar/features/presentation/modules/user_profile/widgets/tab_profile.dart';
import 'package:dinar/features/presentation/modules/user_profile/widgets/verify_component.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../config/values/asset_image.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileController controller = UserProfileController();

  @override
  void initState() {
    controller.checkIsMe();
    super.initState();
  }

  void showCommentForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DialogReport(
        user: controller.user!,
        handleReportUser: controller.handleReportUser,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double sizeImage = 22.wp;
    return Scaffold(
      appBar: MyAppbar(
        title: controller.user!.fullName,
        actions: [
          controller.isMe.value
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      showCommentForm(context);
                    },
                    icon: const Icon(
                      Icons.outlined_flag_rounded,
                      color: AppColors.grey500,
                    ),
                  ),
                ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //avatar ========================================
                    if (controller.user!.avatar != null)
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${apiDevBaseUrl}/images/${controller.user!.avatar!}',
                          fit: BoxFit.cover,
                          width: sizeImage,
                          height: sizeImage,
                          errorWidget: (context, _, __) {
                            return CircleAvatar(
                              radius: sizeImage / 2,
                              backgroundImage:
                                  const AssetImage(Assets.avatarDefault),
                            );
                          },
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: sizeImage / 2,
                        backgroundImage: const AssetImage(Assets.avatarDefault),
                      ),
                    const SizedBox(width: 10),
                    // info ========================================
                    Expanded(
                      child: Column(
                        children: [
                          // info
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Bai viet
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.numberPost.toString(),
                                      style: AppTextStyles.semiBold16
                                          .colorEx(AppColors.grey700),
                                    ),
                                    Text(
                                      "Posts",
                                      style: AppTextStyles.medium12
                                          .colorEx(AppColors.grey700),
                                    ),
                                  ],
                                ),
                                // Người theo dõi
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.numberFollower.toString(),
                                      style: AppTextStyles.semiBold16
                                          .colorEx(AppColors.grey700),
                                    ),
                                    Text(
                                      "Followers",
                                      style: AppTextStyles.medium12
                                          .colorEx(AppColors.grey700),
                                    ),
                                  ],
                                ),
                                // Đang theo dõi
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.numberFollowing.toString(),
                                      style: AppTextStyles.semiBold16
                                          .colorEx(AppColors.grey700),
                                    ),
                                    Text(
                                      "Watching",
                                      style: AppTextStyles.medium12
                                          .colorEx(AppColors.grey700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          // button follow
                          Obx(
                            () => ButtonFollow(
                              isFollow: controller.isFollow.value,
                              isMe: controller.isMe.value,
                              onTap: controller.toggleIsFollow,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // name ============================================
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      controller.user!.fullName,
                      style:
                          AppTextStyles.semiBold16.colorEx(AppColors.grey700),
                    ),
                    const SizedBox(width: 5),
                    const VerifyComponent(isVerify: true, isMe: true),
                  ],
                ),
                // location ========================================
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.location,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80.wp,
                      child: Text(
                        controller.user!.address!.getDetailAddress(),
                        style:
                            AppTextStyles.medium14.colorEx(AppColors.grey500),
                      ),
                    )
                  ],
                ),
                // dateCreate ======================================
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.calendar,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80.wp,
                      child: Text(
                        "Joined date  -${(controller.user!.createdAt != null ? controller.user!.createdAt!.toDMYString() : "null")}",
                        style:
                            AppTextStyles.medium14.colorEx(AppColors.grey500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // tab ==============================================

          const Expanded(child: BorrowerDashboardPage()),
        ],
      ),
      floatingActionButton: Obx(
        () => controller.isMe.value
            ? Container()
            : FloatingActionButton.extended(
                onPressed: () {
                  controller.navToCreateRequest();
                },
                backgroundColor: AppColors.green,
                extendedPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                label: Text(
                  "Create request",
                  style: AppTextStyles.bold12.colorEx(
                    AppColors.white,
                  ),
                ),
              ),
      ),
    );
  }
}

class BorrowerDashboardPage extends StatelessWidget {
  const BorrowerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle('Loan Progress'),
            const SizedBox(height: 10),
            _buildLoanProgress(),
            const SizedBox(height: 20),
            _buildTitle('Loans Overview'),
            const SizedBox(height: 10),
            _buildPieChart(),
            const SizedBox(height: 20),
            _buildTitle('Repayment Schedule'),
            const SizedBox(height: 10),
            _buildLineChart(),
            const SizedBox(height: 20),
            _buildTitle('Total Borrowed vs Repaid'),
            const SizedBox(height: 10),
            _buildBarChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildLoanProgress() {
    double progress = 0.65; // Example progress (65%)
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
              strokeWidth: 8,
            ),
            const SizedBox(height: 10),
            const Text(
              '65% of Loan Repaid',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              '4 months remaining',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: 40,
              title: 'Personal',
              radius: 50,
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 3, 29, 77)),
            ),
            PieChartSectionData(
              color: Colors.orange,
              value: 30,
              title: 'Buss..',
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 77, 69, 3)),
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 20,
              title: 'Education',
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 20, 88, 3)),
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 10,
              title: 'Med',
              radius: 50,
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 77, 36, 3)),
            ),
          ],
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        title: const ChartTitle(text: 'Repayment Schedule'),
        series: <CartesianSeries>[
          LineSeries<ChartData, String>(
            dataSource: [
              ChartData('Jan', 500),
              ChartData('Feb', 700),
              ChartData('Mar', 300),
              ChartData('Apr', 800),
              ChartData('May', 600),
              ChartData('Jun', 400),
            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        title: const ChartTitle(text: 'Total Borrowed vs Repaid'),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: [
              ChartData('Borrowed', 50000),
              ChartData('Repaid', 30000),
            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Colors.teal,
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
