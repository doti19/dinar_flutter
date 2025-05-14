import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/entities/credit/post.dart';
import '../../../../domain/enums/post_status_management.dart';
import '../post_management_controller.dart';
import '../../../global_widgets/base_list_posts.dart';
import 'item_post.dart';

class ListPostsApproved extends StatelessWidget {
  ListPostsApproved({super.key});

  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, PostEntity post) {
    if (i == 0) {
      controller.deletePost(post);
    }
  }

  ItemPost buildItem(PostEntity post) {
    return ItemPost(
      statusCode: PostStatusManagement.approved,
      status: "Approved",
      post: post,
      funcs: const [
        "Delete loan",
      ],
      iconFuncs: const [
        Icons.delete_outline,
      ],
      onSelectedMenu: onSelectedMenu,
      onTap: controller.navigationToPostDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseListPosts(
      titleNull: "There has been no loans that has been approved",
      getPosts: controller.getPostsRejected,
      postsList: controller.approvedPosts,
      buildItem: buildItem,
    );
  }
}
