import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/presentation/global_widgets/base_list_bids.dart';
import 'package:dinar/features/presentation/global_widgets/base_list_posts.dart';
import 'package:dinar/features/presentation/modules/post/widgets/card_sort.dart';
import 'package:dinar/features/presentation/modules/post_detail/post_detail_controller.dart';
import 'package:dinar/features/presentation/modules/post_detail/widgets/bid_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidsListScreen extends StatelessWidget {
  BidsListScreen({super.key});
  final PostDetailController controller = Get.find<PostDetailController>();

  Widget? buildItem(BidEntity bid) {
    return Dismissible(
        key: Key(bid.id.toString()),
        direction: DismissDirection.horizontal,
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            // Swiped right
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Swiped right on item $index')),
            // );
            controller.approveBid(bid.id.toString());
          } else if (direction == DismissDirection.endToStart) {
            // Swiped left
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Swiped left on item $index')),
            // );
          }
          return false;
        },
        background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(Icons.check, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.stop, color: Colors.white),
        ),
        child: BidCard(bid: bid));
  }

  Widget? buildCardSort() {
    return const CardSort();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: BaseListBids(
        // cardSort: buildCardSort(),
        // titleNull: "List Of Bids",
        getBids: controller.getBids,
        bidsList: controller.bids,
        buildItem: buildItem,
      ),
    );
  }
}
