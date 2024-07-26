import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/pending_request_tab.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/sent_request_tab.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/waiting_payment_request_tab.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../widgets/approved_request_tab.dart';
import '../widgets/reject_request_tab.dart';

class RequestTabScreen extends StatefulWidget {
  const RequestTabScreen({super.key});

  @override
  State<RequestTabScreen> createState() => _RequestTabScreenState();
}

class _RequestTabScreenState extends State<RequestTabScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.green,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              SizedBox(
                width: 100.wp / 5,
                child: const Tab(
                  text: "Confirmed",
                ),
              ),
              SizedBox(
                width: 100.wp / 4,
                child: const Tab(
                  text: "Wait for pay",
                ),
              ),
              SizedBox(
                width: 100.wp / 4,
                child: const Tab(
                  text: "Wait for confirmation",
                ),
              ),
              SizedBox(
                width: 100.wp / 5,
                child: const Tab(
                  text: "Sent",
                ),
              ),
              SizedBox(
                width: 100.wp / 5,
                child: const Tab(
                  text: "Cancelled",
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                ApprovedRequestTab(),
                WaitingPaymentRequestTab(),
                PendingRequestTab(),
                SentRequestTab(),
                RejectRequestTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
