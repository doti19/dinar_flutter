// import 'package:dinar/features/domain/entities/credit/bid.dart';
// import 'package:dinar/features/domain/enums/bid_status.dart';
// import 'package:dinar/features/presentation/global_widgets/base_list_bids.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../domain/entities/credit/post.dart';
// import '../../../../domain/enums/post_status_management.dart';
// import '../post_management_controller.dart';
// import '../../../global_widgets/base_list_posts.dart';
// import 'item_post.dart';

// class ListBidsApproved extends StatelessWidget {
//   ListBidsApproved({super.key});

//   final BidManagementController controller =
//       Get.find<BidManagementController>();

//   void onSelectedMenu(int i, PostEntity post) {
//     if (i == 0) {
//       controller.deletePost(post);
//     }
//   }

//   ItemBid buildItem(BidEntity bid) {
//     return ItemBid(
//       statusCode: BidStatus.approved,
//       status: "Approved",
//       bid: bid,
//       funcs: const [
//         "Delete bid",
//       ],
//       iconFuncs: const [
//         Icons.delete_outline,
//       ],
//       onSelectedMenu: onSelectedMenu,
//       onTap: controller.navigationToPostDetail,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseListBids(
//       titleNull: "There has been no loans that has been approved",
//       getBids: controller.getPostsRejected,
//       bidsList: controller.approvedPosts,
//       buildItem: buildItem,
//     );
//   }
// }
