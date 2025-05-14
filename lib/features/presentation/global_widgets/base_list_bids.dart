import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/config/theme/text_styles.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseListBids extends StatefulWidget {
  final Future<Pair<int, List<BidEntity>>> Function({int? page}) getBids;
  final RxList<BidEntity> bidsList;
  final Widget? Function(BidEntity bid) buildItem;
  final String titleNull;
  final Widget? cardSort;
  const BaseListBids(
      {required this.getBids,
      required this.bidsList,
      required this.buildItem,
      this.cardSort,
      this.titleNull = "No Bids posted yet",
      super.key});

  @override
  State<BaseListBids> createState() => _BaseListBidsState();
}

class _BaseListBidsState extends State<BaseListBids> {
  RxBool isLoading = false.obs;
  int page = 1;
  int numOfPage = 1;
  final scrollController = ScrollController();
  RxBool hasMore = true.obs;

  @override
  void initState() {
    refresh();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchMore() async {
    page++;
    if (page <= numOfPage) {
      // Fetch more data and add to the list
      await widget.getBids(page: page).then((value) {
        numOfPage = value.first;
        final newPosts = value.second;
        widget.bidsList.addAll(newPosts);
        hasMore.value = true;
      });
    } else {
      // No more pages to fetch
      hasMore.value = false;
    }
  }

  Future refresh() async {
    isLoading.value = true;
    page = 1;
    hasMore.value = true;
    await widget.getBids().then((value) {
      numOfPage = value.first;
      widget.bidsList.value = value.second;
      numOfPage == 1 ? hasMore.value = false : hasMore.value = true;
    });
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Column(
        children: [
          Text(
            "Bids",
            style: AppTextStyles.bold20.copyWith(color: AppColors.green),
            textAlign: TextAlign.center,
          ),
          widget.cardSort != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: widget.cardSort,
                )
              : const SizedBox(),
          Expanded(
            child: Obx(
              () => isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : widget.bidsList.isEmpty
                      ? Center(
                          child: Text(
                            widget.titleNull,
                            style: AppTextStyles.bold20
                                .copyWith(color: AppColors.green),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: widget.bidsList.length + 1,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index < widget.bidsList.length) {
                              return widget.buildItem(widget.bidsList[index]);
                            } else {
                              return Obx(
                                () => hasMore.value
                                    ? const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : const SizedBox(height: 20),
                              );
                            }
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
