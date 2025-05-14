import 'package:dinar/config/routes/app_routes.dart';
import 'package:dinar/config/theme/app_color.dart';
import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/resources/pair.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:dinar/features/domain/enums/interest_unit_types.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:dinar/features/domain/usecases/bid/remote/approve_bid.dart';
import 'package:dinar/features/domain/usecases/bid/remote/get_bids.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../di/injection_container.dart';
import '../../../domain/usecases/authentication/get_user_id.dart';
import '../../../domain/usecases/bid/remote/create_bid.dart';

class PostDetailController extends GetxController {
  final PostEntity post = Get.arguments as PostEntity;

  RxList<BidEntity> bids = <BidEntity>[].obs;

  RxBool isLoading = false.obs;
  RxBool isInCash = true.obs;
  setIsInCash(bool value) {
    isInCash.value = value;
  }

  toggleIsLoading(bool value) {
    isLoading.value = value;
  }

  final bidInCashFormKey = GlobalKey<FormState>();
  final bidInKindFormKey = GlobalKey<FormState>();

  late bool isYourPost = false;
  final int numOfStars = 4;

  final RxBool isLiked = false.obs;

  GetUserIdUseCase get _getUserIdUseCase => sl<GetUserIdUseCase>();
  @override
  onInit() async {
    isYourPost = (post.user!.id == await _getUserIdUseCase());
    super.onInit();
  }

  Future<Pair<int, List<BidEntity>>> getBids({int? page}) async {
    final GetBidsByPostUseCase getPostsUseCase = sl<GetBidsByPostUseCase>();
    final dataState = await getPostsUseCase(params: Pair(post.id!, page));

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<void> approveBid(String bidId) async {
    // final userId = await _getUserIdUseCase();
    ApproveBidUseCase approveBidUseCase = sl<ApproveBidUseCase>();
    final dataState = await approveBidUseCase(params: bidId);
    if (dataState is DataSuccess) {
      Get.snackbar(
        'Bid successfully',
        'Go to bid management to view your bids',
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Bid failed',
        '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void bid() async {
    toggleIsLoading(true);
    if (isYourPost) {
      Get.snackbar(
        'Bid failed',
        'You Can\'t bid on your own post',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      toggleIsLoading(false);
      return;
    }

    CreateBidUseCase createBidUseCase = sl<CreateBidUseCase>();
    if (!validatorForm()) return;
    final BidParams bid = await getNewBid();
    print('abet $post');
    final dataState = await createBidUseCase(params: bid);
    if (dataState is DataSuccess) {
      toggleIsLoading(false);
      //update post

      Get.snackbar(
        'Bid successfully',
        'Go to bid management to view your bids',
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
      Get.back();
    } else {
      toggleIsLoading(false);
      Get.snackbar(
        'Bid failed',
        '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    toggleIsLoading(false);
  }

  bool validatorForm() {
    bool isValidate = true;
    if (isInCash.value) {
      isValidate = isValidate & bidInCashFormKey.currentState!.validate();
    } else {
      isValidate = isValidate & bidInKindFormKey.currentState!.validate();
    }
    return isValidate;
  }

  Future<BidParams> getNewBid() async {
    // final userId = await _getUserIdUseCase();

    if (isInCash.value) {
      return BidParams(
        amount: amount,
        interestRate: interestRate,
        tenure: tenure,
        unit: InterestUnitTypes.parse(
          interestRateUnit.value.toLowerCase(),
        ),
        type: PostTypes.inCash,
        postId: post.id,
      );
    } else {
      return BidParams(
        amount: amount,
        interestRate: interestRate,
        unit: InterestUnitTypes.parse(
          interestRateUnit.value.toLowerCase(),
        ),
        tenure: tenure,
        type: PostTypes.inKind,
        postId: post.id,
      );
    }
  }

  final amountTextController = TextEditingController();
  double? amount;
  final interestRateTextController = TextEditingController();
  double? interestRate;
  final tenureTextController = TextEditingController();
  int? tenure;

  List<String> timeTypes = ["Month", "Year"];
  RxString interestRateUnit = 'Month'.obs;
  void setInterestRateUnit(String? value) {
    interestRateUnit.value = value!;
  }

  toggleIsLiked() {
    isLiked.value = !isLiked.value;
  }

  void navToUserProfile() {
    Get.toNamed(AppRoutes.userProfile, arguments: post.user);
  }

  void likePost() async {}
}
