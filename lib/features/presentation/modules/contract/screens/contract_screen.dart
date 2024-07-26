import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/modules/contract/screens/contract_tab_screen.dart';
import 'package:dinar/features/presentation/modules/contract/screens/request_tab_screen.dart';
import 'package:flutter/material.dart';
import '../../../global_widgets/my_tab_appbar.dart';
import '../contract_controler.dart';

class ContractScreen extends StatelessWidget {
  ContractScreen({super.key});

  final ContractController controller = ContractController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const MyTabAppbar(
          title: "Contract",
          tabTitle1: "Request",
          tabTitle2: "Contract",
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            RequestTabScreen(),
            ContractTabScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
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
