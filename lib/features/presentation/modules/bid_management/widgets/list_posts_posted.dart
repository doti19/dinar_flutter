// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../domain/entities/credit/post.dart';
// import '../../../../domain/enums/post_status_management.dart';
// import '../post_management_controller.dart';
// import '../../../global_widgets/base_list_posts.dart';
// import 'item_post.dart';

// class ListBidsPosted extends StatelessWidget {
//   ListBidsPosted({super.key});
//   final BidManagementController controller =
//       Get.find<BidManagementController>();

//   void onSelectedMenu(int i, PostEntity post) {
//     if (i == 0) {
//       controller.hidePost(post);
//     } else if (i == 1) {
//       controller.editPost(post);
//     } else if (i == 2) {
//       controller.deletePost(post);
//     } else if (i == 3) {
//       controller.extensionPost(post);
//     }
//   }

//   ItemPost buildItem(PostEntity post) {
//     return ItemPost(
//       statusCode: PostStatusManagement.approved,
//       status: "Approved",
//       post: post,
//       funcs: const [
//         "Hide loan",
//         "Edit",
//         "Delete loan",
//         "Extend",
//       ],
//       iconFuncs: const [
//         Icons.remove_red_eye_outlined,
//         Icons.edit,
//         Icons.delete_outline,
//         Icons.timer_outlined,
//       ],
//       onSelectedMenu: onSelectedMenu,
//       onTap: controller.navigationToPostDetail,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseListPosts(
//       titleNull: "No loans posted yet",
//       getPosts: controller.getPostsApproved,
//       postsList: controller.approvedPosts,
//       buildItem: buildItem,
//     );
//   }
// }
