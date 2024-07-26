import 'package:dinar/features/domain/entities/credit/loan_request.dart';
import 'package:dinar/features/presentation/modules/contract/contract_controler.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/base_list_request.dart';
import 'package:dinar/features/presentation/modules/contract/widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovedRequestTab extends StatelessWidget {
  ApprovedRequestTab({super.key});

  final ContractController controller = Get.find<ContractController>();

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BaseListRequests(
        titleNull: "No loans posted yet",
        getRequest: controller.getRequestsApproved,
        requestsList: controller.approvedRequests,
        buildItem: buildItem,
      ),
    );
  }
}
