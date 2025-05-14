import 'dart:io';
import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:dinar/features/domain/enums/interest_unit_types.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../di/injection_container.dart';
import '../../../domain/enums/loan_reason_types.dart';
import '../../../domain/usecases/media/upload_images.dart';
import '../../../domain/usecases/post/remote/create_post.dart';

class CreatePostController extends GetxController {
  RxBool isLoading = false.obs;
  toggleIsLoading(bool value) {
    isLoading.value = value;
  }

  // create Post
  final infoFormKey = GlobalKey<FormState>();
  final inCashFormKey = GlobalKey<FormState>();
  final inKindFormKey = GlobalKey<FormState>();

  Future<void> createPost({required bool hasImages}) async {
    toggleIsLoading(true);
    CreatePostsUseCase createPostsUseCase = sl<CreatePostsUseCase>();

    if (!validatorForm()) return;
    final PostEntity post = await getNewPost(hasImages: hasImages);
    print('tedi afro ${post}');
    final dataState = await createPostsUseCase(params: post);

    if (dataState is DataSuccess) {
      toggleIsLoading(false);
      Get.back();
      Get.snackbar(
        'Posted successfully',
        'Go to post management to view your posts',
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } else {
      toggleIsLoading(false);
      Get.snackbar(
        'Posting failed',
        '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool validatorForm() {
    bool isValidate = true;
    isValidate = isValidate & infoFormKey.currentState!.validate();
    if (isInCash.value) {
      print('ywage ${inCashFormKey.currentState!}');
      isValidate = isValidate & inCashFormKey.currentState!.validate();
    } else {
      isValidate = isValidate & inKindFormKey.currentState!.validate();
    }
    return isValidate;
  }

  Future<PostEntity> getNewPost({required bool hasImages}) async {
    List<String> images = hasImages ? [] : await uploadImages();

    if (isInCash.value) {
      // Lending
      return PostEntity(
        type: PostTypes.inCash,
        title: title,
        description: description,
        images: images,
        loanReasonType: borrowingLoanReasonType.value,
        loanReason: borrowingLoanReason,
        loanAmount: lendingLoanAmount,
        maxLoanAmount: lendingMaxLoanAmount,
        interestRate: lendingInterestRate != null
            ? InterestRate(
                interest: lendingInterestRate!,
                unit: InterestUnitTypes.parse(
                    interestRateUnit.value.toLowerCase()))
            : null,
        maxInterestRate: lendingMaxInterestRate != null
            ? InterestRate(
                interest: lendingMaxInterestRate!,
                unit: InterestUnitTypes.parse(
                    interestRateUnit.value.toLowerCase()))
            : null,
        tenureMonths: lendingTenureMonths,
        maxTenureMonths: lendingMaxTenureMonths,
        overdueInterestRate: lendingOverdueInterestRate != null
            ? InterestRate(
                interest: lendingOverdueInterestRate!,
                unit: InterestUnitTypes.parse(
                    overdueInterestRateUnit.value.toLowerCase()))
            : null,
        maxOverdueInterestRate: lendingMaxOverdueInterestRate != null
            ? InterestRate(
                interest: lendingMaxOverdueInterestRate!,
                unit: InterestUnitTypes.parse(
                    overdueInterestRateUnit.value.toLowerCase()))
            : null,
        postExpiresAfter: postExpiresAfter ?? 3,
      );
    } else {
      return PostEntity(
        type: PostTypes.inKind,
        title: title,
        description: description,
        postExpiresAfter: postExpiresAfter,
        images: images,
        // interestRate: borrowingInterestRate,
        tenureMonths: borrowingTenureMonths,
      );
    }
  }

  Future<List<String>> uploadImages() async {
    UploadImagesUseCase uploadImagessUseCase = sl<UploadImagesUseCase>();

    final dataState = await uploadImagessUseCase(params: photo);

    if (dataState is DataSuccess) {
      toggleIsLoading(false);
      return dataState.data!;
    } else {
      toggleIsLoading(false);
      return [];
    }
  }

  List<String> timeTypes = ["Month", "Year"];
  RxString interestRateUnit = 'Month'.obs;
  void setInterestRateUnit(String? value) {
    interestRateUnit.value = value!;
  }

  RxString overdueInterestRateUnit = 'Month'.obs;
  void setOverdueInterestRateUnit(String? value) {
    overdueInterestRateUnit.value = value!;
  }

  RxString periodUnit = 'Month'.obs;
  void setPeriodUnit(String? value) {
    periodUnit.value = value!;
  }

  // choose is lending
  RxBool isInCash = true.obs;
  setIsInCash(bool value) {
    isInCash.value = value;
  }

  // card post info
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final postExpiresAfterTextController = TextEditingController();
  String? title;
  String? description;
  int? postExpiresAfter;

  // Lending form
  final lendingLoanAmountTextController = TextEditingController();
  double? lendingLoanAmount;
  final loantypeControllerr = TextEditingController();
  String? loantypeController;
  final lendingMaxLoanAmountTextController = TextEditingController();
  double? lendingMaxLoanAmount;
  final lendingInterestRateTextController = TextEditingController();
  double? lendingInterestRate;
  final lendingMaxInterestRateTextController = TextEditingController();
  double? lendingMaxInterestRate;
  final lendingTenureMonthsTextController = TextEditingController();
  int? lendingTenureMonths;
  final lendingMaxTenureMonthsTextController = TextEditingController();
  int? lendingMaxTenureMonths;
  final lendingOverdueInterestRateTextController = TextEditingController();
  double? lendingOverdueInterestRate;
  final lendingMaxOverdueInterestRateTextController = TextEditingController();
  double? lendingMaxOverdueInterestRate;

  // Borrowing form
  // final borrowingLoanAmountTextController = TextEditingController();
  // double? borrowingLoanAmount;
  // final borrowingInterestRateTextController = TextEditingController();
  // double? borrowingInterestRate;
  // final borrowingOverdueInterestRateTextController = TextEditingController();
  // double? borrowingOverdueInterestRate;
  final borrowingTenureMonthsTextController = TextEditingController();
  int? borrowingTenureMonths;
  final Rxn<LoanReasonTypes> borrowingLoanReasonType = Rxn(null);
  void setLoanReason(LoanReasonTypes value) {
    borrowingLoanReasonType.value = value;
  }

  final borrowingLoanReasonTextController = TextEditingController();
  String? borrowingLoanReason;

  // hinh anh
  bool? photoController;

  void checkLengthPhoto() {
    int length = photo.length + imageUrlList.length;
    if (length >= 3 && length <= 12) {
      photoController = true;
    } else {
      photoController = false;
    }
    update();
  }

  List<File> photo = [];
  List<String> imageUrlList = [];
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedImages = await _picker.pickMultiImage();
    for (int i = 0; i < pickedImages.length; i++) {
      photo.add(File(pickedImages[i].path));
    }
    checkLengthPhoto();
    update();
  }

  Future imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      photo.add(File(image.path));
      checkLengthPhoto();
      update();
    }
  }

  void deleteImage(int index) {
    if (index < imageUrlList.length) {
      imageUrlList.removeAt(index);
    } else {
      photo.removeAt(index - imageUrlList.length);
    }
    checkLengthPhoto();
    update();
  }
}
