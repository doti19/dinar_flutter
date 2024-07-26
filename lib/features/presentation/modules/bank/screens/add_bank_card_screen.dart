import 'package:dinar/core/extensions/integer_ex.dart';
import 'package:dinar/core/extensions/textstyle_ex.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:dinar/features/presentation/modules/bank/bank_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../global_widgets/base_textfield.dart';

class AddBankCardScreen extends StatefulWidget {
  const AddBankCardScreen({super.key});

  @override
  State<AddBankCardScreen> createState() => _AddBankCardScreenState();
}

class _AddBankCardScreenState extends State<AddBankCardScreen> {
  final BankController controller = Get.find();

  final FocusNode _moneyFocusNode = FocusNode();

  @override
  void initState() {
    controller.cardNumberController.text = controller.selectedBank!.bin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Add bank card"),
      body: ListView(
        children: [
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // avatar
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: CachedNetworkImage(
                              imageUrl: controller.selectedBank!.logo,
                              fit: BoxFit.contain,
                              width: 70,
                              height: 50,
                              errorWidget: (context, _, __) {
                                return const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(Assets.avatar2),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.selectedBank!.shortName,
                                  style: AppTextStyles.bold14.colorEx(
                                    AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.selectedBank!.name,
                                  style: AppTextStyles.regular14.colorEx(
                                    AppColors.grey700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      BaseTextField(
                          focusNode: _moneyFocusNode,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: controller.cardNumberController,
                          labelText: 'Card/account number',
                          hintText: "Enter card/account number",
                          onSaved: (value) {
                            try {
                              controller.cardNumber = value!.trim();
                            } catch (e) {
                              controller.cardNumber = "";
                            }
                          },
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter card/account number";
                            }
                            // check card number
                            if (value.trim().length < 16) {
                              return "Card/account number less than 16 characters";
                            }
                            // validate all is number
                            if (!value.isNum) {
                              return "Card/account number must be numeric";
                            }
                            // check bank number is begin with bin
                            if (!value
                                .startsWith(controller.selectedBank!.bin)) {
                              return "The card/account number must start with number ${controller.selectedBank!.bin}";
                            }
                            return null;
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
          // thêm ngân hàng ============================================
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: controller.isLoadingAddBankCard.value
                    ? null
                    : () {
                        controller.addBankCard();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(color: AppColors.white),
                  elevation: 10,
                  minimumSize: Size(100.wp, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: controller.isLoadingAddBankCard.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Add bank card'.tr,
                        style: AppTextStyles.bold14.colorEx(AppColors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
